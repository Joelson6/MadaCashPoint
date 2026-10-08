package com.cuf.cuf_recouvrement_mobile

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "saveToDownloads" -> {
                        val path = call.argument<String>("path")
                        val fileName = call.argument<String>("fileName")
                        val mime = call.argument<String>("mime") ?: "image/png"
                        if (path.isNullOrEmpty() || fileName.isNullOrEmpty()) {
                            result.error("bad_args", "path/fileName manquants", null)
                        } else {
                            try {
                                result.success(saveToDownloads(File(path), fileName, mime))
                            } catch (e: Exception) {
                                result.error("save_failed", e.message, e.toString())
                            }
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Copie [source] dans le dossier public `Download/CUF` :
     *  - API 29+ : MediaStore.Downloads (aucune permission requise) ;
     *  - API 26-28 : écriture directe (permission WRITE_EXTERNAL_STORAGE,
     *    déclarée avec maxSdkVersion=28 dans le manifeste).
     *
     * Anti-doublon : si le nom existe déjà, un suffixe ` (n)` est ajouté.
     * Retourne le chemin relatif retenu (`Download/CUF/<nom>`).
     */
    private fun saveToDownloads(source: File, fileName: String, mime: String): String {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val resolver = contentResolver

            var name = fileName
            var attempt = 0
            while (downloadsNameExists(resolver, name)) {
                attempt++
                name = withSuffix(fileName, attempt)
            }

            val values = ContentValues().apply {
                put(MediaStore.Downloads.DISPLAY_NAME, name)
                put(MediaStore.Downloads.MIME_TYPE, mime)
                put(
                    MediaStore.Downloads.RELATIVE_PATH,
                    Environment.DIRECTORY_DOWNLOADS + "/CUF",
                )
                put(MediaStore.Downloads.IS_PENDING, 1)
            }
            val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
                ?: throw IllegalStateException("insert MediaStore impossible")
            resolver.openOutputStream(uri)?.use { out ->
                FileInputStream(source).use { input -> input.copyTo(out) }
            } ?: throw IllegalStateException("flux d'écriture indisponible")

            values.clear()
            values.put(MediaStore.Downloads.IS_PENDING, 0)
            resolver.update(uri, values, null, null)
            return Environment.DIRECTORY_DOWNLOADS + "/CUF/" + name
        }

        val dir = File(
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS),
            "CUF",
        )
        if (!dir.exists() && !dir.mkdirs()) {
            throw IllegalStateException("dossier Download/CUF inaccessible")
        }
        var name = fileName
        var attempt = 0
        var target = File(dir, name)
        while (target.exists()) {
            attempt++
            name = withSuffix(fileName, attempt)
            target = File(dir, name)
        }
        source.copyTo(target, overwrite = true)
        return Environment.DIRECTORY_DOWNLOADS + "/CUF/" + name
    }

    private fun downloadsNameExists(resolver: android.content.ContentResolver, name: String): Boolean {
        resolver.query(
            MediaStore.Downloads.EXTERNAL_CONTENT_URI,
            arrayOf(MediaStore.Downloads.DISPLAY_NAME),
            "${MediaStore.Downloads.DISPLAY_NAME} = ?",
            arrayOf(name),
            null,
        )?.use { cursor ->
            return cursor.count > 0
        }
        return false
    }

    private fun withSuffix(fileName: String, attempt: Int): String {
        val dot = fileName.lastIndexOf('.')
        return if (dot > 0) {
            fileName.substring(0, dot) + " ($attempt)" + fileName.substring(dot)
        } else {
            "$fileName ($attempt)"
        }
    }

    companion object {
        private const val CHANNEL_NAME = "cuf_recouvrement/media"
    }
}
