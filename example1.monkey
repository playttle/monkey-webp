
Import webp
Import mojo

Import "./example1-pic1.jpg"
Import "./example1-pic1.webp"

#IMAGE_FILES="*.png|*.jpg|*.webp"

Function Main:Int()
	New TestApp

	Return 0
End Function

Class TestApp Extends App
	Field pic1:Image

	Method AssertNotNull(t:Object)
		If t = Null Then
			Error("Object is null")
		End If
	End Method

	Method OnCreate:Int()
		SetUpdateRate(60)

		Local t1:Int, t2:Int

		t1 = Millisecs()
		AssertNotNull(LoadImage("example1-pic1.jpg"))
		t2 = Millisecs()
		Print("TestApp - JPEG loading time: " + (t2 - t1) + " ms")

		t1 = Millisecs()
		pic1 = WebP.LoadImage("example1-pic1.webp")
		AssertNotNull(pic1)
		t2 = Millisecs()
		Print("TestApp - WEBP loading time: " + (t2 - t1) + " ms")

		Return 0
	End Method

	Method OnUpdate:Int()
		Return 0
	End Method

	Method OnRender:Int()
		Cls(0, 0, 0)

		DrawImage(pic1, 0, 0)

		DrawText("WebP example", 0, 0)

		If TouchHit(0) Error("")
			
		Return 0
	End Method
End Class




