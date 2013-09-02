
import java.io.*;

import android.backport.webp.WebPFactory;

class WebPGlue {
	static byte[] _StreamToBytes(InputStream is) {
		ByteArrayOutputStream os = new ByteArrayOutputStream(1024);
		byte[] buffer = new byte[1024];
		int len;
		try {
			while ((len = is.read(buffer)) >= 0) {
				os.write(buffer, 0, len);
			}
		} catch (java.io.IOException e) {
		}
		return os.toByteArray();
	}

	static gxtkSurface LoadSurface(String path) {
		InputStream is = bb_graphics.g_device.game.OpenInputStream(path);
		if (is == null) {
			return null;
		}

		Bitmap bitmap = WebPFactory.nativeDecodeByteArray(_StreamToBytes(is), null);
		if (bitmap == null) {
			return null;
		}

		gxtkSurface surface = new gxtkSurface();
		surface.SetBitmap( bitmap );
		
		return surface;
	}
}
