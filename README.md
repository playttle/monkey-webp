# WebP for Monkey

This Monkey module allows you to load WebP images.

Supported targets: Android, iOS.

The module uses the WebP Android Backport library: [github.com/alexey-pelykh/webp-android-backport](https://github.com/alexey-pelykh/webp-android-backport).

## Installation

1. Go to the Monkey `modules_ext` directory 
2. `git clone https://github.com/playttle/monkey-webp.git webp`
3. `git submodule update --init`

### Android

1. Add a reference to the library in the `yourgame.build/android/project.properties` file:

        # Project target.
        target=android-13
        android.library.reference.1=../../webp/native/webp-android-backport/webp-android-backport-library
       
2. Copy the `yourgame.build/android/local.properties` file from the your Android project to `webp/native/webp-android-backport-library`. It contains a path to your Android SDK. Done!
3. If you have pulled the source code from *github.com*, you will need to compile the native library using the Android NDK. From the command line, you shall call the `ndk-build` command in the `webp/native/webp-android-backport-library` directory. Also change target to android-13 at `webp/native/webp-android-backport-library/project.properties`.

### iOS

iOS target uses the webp library which comes with the webp-android-backport-library.

If you have pulled the source code from *github.com*, it requires to compile `WebP.framework`. Run the `iosbuild.sh` script from the `webp/native/webp-android-backport/webp-android-backport-library/jni/webp` directory. The script will create the `WebP.framework` directory. Unfortunately, Monkey doesn't support import of the external frameworks, so in the `WebP.framework` directory rename `WebP` to `WebP.a`.

## Usage

```
Import webp
...
Local img:Image = WebP.LoadImage("picture.webp")
...
DrawImage(img, 0, 0)
```

Use [cwebp](https://developers.google.com/speed/webp/docs/cwebp) utility to convert images into WebP format.

## Testing

To run the example app:

```
$ transcc_macos -target=Android_Game -run example1.monkey
```

Photo courtesy of [www.flickr.com/photos/camas](http://www.flickr.com/photos/camas/9644419065/)

## Contributing

1. Fork it.
2. Create a branch (`git checkout -b work`)
3. Commit your changes (`git commit -am "Description."`)
4. Push to the branch (`git push origin work`)
5. Open a [Pull Request](https://github.com/playttle/monkey-webp)
6. *(Optional)* Follow our blog on [Tumblr](http://blog.playttle.com/), enjoy a refreshing Diet Coke and wait

## License

WebP for Monkey is released under the zlib/libpng license:

```
Copyright (c) 2013 Playttle LLC

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

   1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

   2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

   3. This notice may not be removed or altered from any source
   distribution.
```
