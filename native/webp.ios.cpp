
#import "decode.h"

class WebPGlue {
public:
	static gxtkSurface *LoadSurface(String path);
};

gxtkSurface *WebPGlue::LoadSurface(String path) {
	NSData *rawData = 0;

	if( path.StartsWith( "monkey://data/" ) ){
		path=path.Slice( 14 );
		NSString *nspath=path.ToNSString();
		NSString *ext=[nspath pathExtension];
		NSString *file=[[nspath lastPathComponent] stringByDeletingPathExtension];
		NSString *dir=[@"data/" stringByAppendingString:[nspath stringByDeletingLastPathComponent]];
		NSString *rpath=[[NSBundle mainBundle] pathForResource:file ofType:ext inDirectory:dir];

		rawData = [NSData dataWithContentsOfFile:rpath];
	}else{
		if( NSURL *url=BBIosGame::IosGame()->PathToNSURL( path ) ){
			rawData = [NSData dataWithContentsOfURL:url];
		}
	}

	if (rawData == 0) {
		return 0;
	}

	int width = 0;
	int height = 0;

	unsigned char *data = WebPDecodeRGBA((unsigned char *)[rawData bytes], [rawData length], &width, &height);
	if (!data) {
		return 0;
	}

	gxtkSurface *surface = new gxtkSurface();
	surface->SetData(data, width, height);

	if (surface && !surface->OnUnsafeLoadComplete()) {
		surface = 0;
	}

	return surface;
}

