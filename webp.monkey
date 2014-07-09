' Monkey WebP
' ===========
'
' See the README.md for more information
' 

Strict

Import mojo
Import mojo.data
Import mojo.graphicsdevice

#If TARGET="android" And LANG="java"

	#WEBP_IMPLEMENTED=True

	Import "native/webp.${TARGET}.${LANG}"
	
	Extern
	Class WebPGlue
		Function LoadSurface:Surface(path:String)
	End Class

#ElseIf TARGET="ios" And LANG="cpp"

	#WEBP_IMPLEMENTED=True

	#LIBS+="${CD}/native/webp-android-backport/webp-android-backport-library/jni/webp/WebP.framework/WebP.a"
	#LIBS+="${CD}/native/webp-android-backport/webp-android-backport-library/jni/webp/WebP.framework/Headers/decode.h"
	#LIBS+="${CD}/native/webp-android-backport/webp-android-backport-library/jni/webp/WebP.framework/Headers/types.h"

	Import "native/webp.${TARGET}.${LANG}"
	
	Extern
	Class WebPGlue
		Function LoadSurface:Surface(path:String)
	End Class

#EndIf
#WEBP_IMPLEMENTED=False

Public

#If WEBP_IMPLEMENTED
Class WebP
	Function LoadImage:Image( path:String, frameCount:Int=1, flags:Int=Image.DefaultFlags )
		Local surf := WebPGlue.LoadSurface( FixDataPath(path) )
		If surf Then
			Return (New Image()).Init(surf, frameCount, flags)
		End If
		Return Null
	End Function

	Function LoadImage:Image( path:String, frameWidth:Int, frameHeight:Int, frameCount:Int, flags:Int=Image.DefaultFlags )
		Local atlas := WebP.LoadImage(path, 1, 0)
		If atlas Then
			Return atlas.GrabImage(0, 0, frameWidth, frameHeight, frameCount, flags)
		End If
		Return Null
	End Function
End Class
#Else
Class WebP
	Function LoadImage:Image(path:String, frameCount:Int=1, flags:Int=Image.DefaultFlags)
		Error("WebP is not available.")
		Return Null
	End Function

	Function LoadImage:Image(path:String, frameWidth:Int, frameHeight:Int, frameCount:Int, flags:Int=Image.DefaultFlags)
		Error("WebP is not available.")
		Return Null
	End Function
End Class
#EndIf
