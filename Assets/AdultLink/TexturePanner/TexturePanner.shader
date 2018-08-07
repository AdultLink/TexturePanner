// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AdultLink/TexturePanner"
{
	Properties
	{
		[NoScaleOffset]_Tex("Tex", 2D) = "white" {}
		_Tiling("Tiling", Vector) = (1,1,0,0)
		_Offset("Offset", Vector) = (0,0,0,0)
		[HDR]_Color("Color", Color) = (0,0,0,0)
		[KeywordEnum(Original,Hueshift,Multiply,Replace)] _Colormode("Color mode", Float) = 2
		[Toggle]_Globalemissionflicker("Global emission flicker", Float) = 0
		_Globalemissionflickeramplitude("Global emission flicker amplitude", Float) = 0.5
		_Globalemissionflickerfreq("Global emission flicker freq", Float) = 1
		_Globalemissionflickeroffset("Global emission flicker offset", Float) = 1
		[Toggle]_ScanlinesY("Scanlines Y", Float) = 0
		[Toggle]_ScanlinesZ("Scanlines Z", Float) = 0
		[Toggle]_ScanlinesX("Scanlines X", Float) = 0
		_ScanlinesscaleZ("Scanlines scale Z", Float) = 30
		_ScanlinesscaleX("Scanlines scale X", Float) = 30
		_ScanlinesscaleY("Scanlines scale Y", Float) = 30
		_ScanlinesspeedX("Scanlines speed X", Float) = -5
		_ScanlinesspeedY("Scanlines speed Y", Float) = -5
		_ScanlinesspeedZ("Scanlines speed Z", Float) = -5
		[Toggle]_SharpY("SharpY", Float) = 1
		[Toggle]_SharpZ("SharpZ", Float) = 1
		[Toggle]_SharpX("SharpX", Float) = 1
		_ScrollingspeedX("Scrolling speed X", Float) = -1
		_ScrollingspeedY("Scrolling speed Y", Float) = 0
		[Toggle]_Verticalstretch("Vertical stretch", Float) = 0
		_Verticalstretchamplitude("Vertical stretch amplitude", Range( 0 , 1)) = 0.5
		_Verticalstretchfreq("Vertical stretch freq", Float) = 0.5
		_Verticalstretchoffset("Vertical stretch offset", Float) = 0
		_Verticalstretchpivotpoint("Vertical stretch pivot point", Range( -1 , 1)) = 0
		[Toggle]_Verticalmovement("Vertical movement", Float) = 0
		_Verticalmovementamplitude("Vertical movement amplitude", Float) = 0.5
		_Verticalmovementfreq("Vertical movement freq", Float) = 1
		_Verticalmovementoffset("Vertical movement offset", Float) = 0
		_RotationSpeed("Rotation Speed", Float) = 1
		[KeywordEnum(Scroll,Rotate,None)] _Scrollrotate("Scroll rotate", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _COLORMODE_ORIGINAL _COLORMODE_HUESHIFT _COLORMODE_MULTIPLY _COLORMODE_REPLACE
		#pragma shader_feature _SCROLLROTATE_SCROLL _SCROLLROTATE_ROTATE _SCROLLROTATE_NONE
		#pragma surface surf Standard alpha:fade keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform float _Verticalmovement;
		uniform float _Verticalmovementfreq;
		uniform float _Verticalmovementamplitude;
		uniform float _Verticalmovementoffset;
		uniform float _Verticalstretch;
		uniform float _Verticalstretchfreq;
		uniform float _Verticalstretchamplitude;
		uniform float _Verticalstretchoffset;
		uniform float _Verticalstretchpivotpoint;
		uniform sampler2D _Tex;
		uniform float _ScrollingspeedX;
		uniform float _ScrollingspeedY;
		uniform float2 _Tiling;
		uniform float2 _Offset;
		uniform float _RotationSpeed;
		uniform float _Globalemissionflicker;
		uniform float _Globalemissionflickerfreq;
		uniform float _Globalemissionflickeramplitude;
		uniform float _Globalemissionflickeroffset;
		uniform float _ScanlinesX;
		uniform float _SharpX;
		uniform float _ScanlinesscaleX;
		uniform float _ScanlinesspeedX;
		uniform float _ScanlinesY;
		uniform float _SharpY;
		uniform float _ScanlinesscaleY;
		uniform float _ScanlinesspeedY;
		uniform float _ScanlinesZ;
		uniform float _SharpZ;
		uniform float _ScanlinesscaleZ;
		uniform float _ScanlinesspeedZ;
		uniform float4 _Color;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float mulTime111 = _Time.y * _Verticalmovementfreq;
			float mulTime91 = _Time.y * _Verticalstretchfreq;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 Vertexpos163 = ase_vertex3Pos;
			float4 appendResult86 = (float4(0.0 , ( lerp(0.0,(sin( mulTime111 )*_Verticalmovementamplitude + _Verticalmovementoffset),_Verticalmovement) + lerp(0.0,( (sin( mulTime91 )*_Verticalstretchamplitude + _Verticalstretchoffset) * ( _Verticalstretchpivotpoint + Vertexpos163.y ) ),_Verticalstretch) ) , 0.0 , 0.0));
			v.vertex.xyz += appendResult86.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult70 = (float2(_ScrollingspeedX , _ScrollingspeedY));
			float2 uv_TexCoord7 = i.uv_texcoord * _Tiling + (float2( 0,0 ) + (_Offset - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 360,360 ) - float2( 0,0 )));
			float2 panner4 = ( _Time.y * appendResult70 + uv_TexCoord7);
			float mulTime181 = _Time.y * _RotationSpeed;
			float cos179 = cos( mulTime181 );
			float sin179 = sin( mulTime181 );
			float2 rotator179 = mul( i.uv_texcoord - float2( 0.5,0.5 ) , float2x2( cos179 , -sin179 , sin179 , cos179 )) + float2( 0.5,0.5 );
			#if defined(_SCROLLROTATE_SCROLL)
				float2 staticSwitch187 = panner4;
			#elif defined(_SCROLLROTATE_ROTATE)
				float2 staticSwitch187 = rotator179;
			#elif defined(_SCROLLROTATE_NONE)
				float2 staticSwitch187 = uv_TexCoord7;
			#else
				float2 staticSwitch187 = panner4;
			#endif
			float mulTime99 = _Time.y * _Globalemissionflickerfreq;
			float mulTime147 = _Time.y * _ScanlinesspeedX;
			float clampResult150 = clamp( sin( (i.uv_texcoord.x*_ScanlinesscaleX + mulTime147) ) , 0.0 , 1.0 );
			float mulTime26 = _Time.y * _ScanlinesspeedY;
			float clampResult175 = clamp( sin( (i.uv_texcoord.y*_ScanlinesscaleY + mulTime26) ) , 0.0 , 1.0 );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float mulTime154 = _Time.y * _ScanlinesspeedZ;
			float clampResult157 = clamp( sin( (ase_vertex3Pos.z*_ScanlinesscaleZ + mulTime154) ) , 0.0 , 1.0 );
			float4 CombinedTexture41 = ( tex2D( _Tex, staticSwitch187 ) * ( lerp(1.0,(pow( sin( mulTime99 ) , 2.0 )*(0.0 + (_Globalemissionflickeramplitude - 0.0) * (0.1 - 0.0) / (1.0 - 0.0)) + _Globalemissionflickeroffset),_Globalemissionflicker) * lerp(1.0,lerp(clampResult150,ceil( clampResult150 ),_SharpX),_ScanlinesX) * lerp(1.0,lerp(clampResult175,ceil( clampResult175 ),_SharpY),_ScanlinesY) * lerp(1.0,lerp(clampResult157,ceil( clampResult157 ),_SharpZ),_ScanlinesZ) ) );
			float3 hsvTorgb125 = RGBToHSV( CombinedTexture41.rgb );
			float3 hsvTorgb126 = RGBToHSV( _Color.rgb );
			float3 hsvTorgb127 = HSVToRGB( float3(( hsvTorgb125.x + hsvTorgb126.x ),hsvTorgb125.y,hsvTorgb125.z) );
			float CombinedTexture_alpha51 = CombinedTexture41.a;
			#if defined(_COLORMODE_ORIGINAL)
				float4 staticSwitch40 = CombinedTexture41;
			#elif defined(_COLORMODE_HUESHIFT)
				float4 staticSwitch40 = float4( hsvTorgb127 , 0.0 );
			#elif defined(_COLORMODE_MULTIPLY)
				float4 staticSwitch40 = ( CombinedTexture41 * _Color );
			#elif defined(_COLORMODE_REPLACE)
				float4 staticSwitch40 = ( _Color * CombinedTexture_alpha51 );
			#else
				float4 staticSwitch40 = ( CombinedTexture41 * _Color );
			#endif
			o.Emission = staticSwitch40.rgb;
			o.Alpha = CombinedTexture_alpha51;
		}

		ENDCG
	}
	CustomEditor "TexturePannerEditor"
}
/*ASEBEGIN
Version=15401
619;100;948;558;1570.443;676.7044;1.771256;True;False
Node;AmplifyShaderEditor.RangedFloatNode;162;-2252.028,1519.028;Float;False;Property;_ScanlinesspeedZ;Scanlines speed Z;17;0;Create;True;0;0;False;0;-5;-5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2189.103,1238.544;Float;False;Property;_ScanlinesspeedY;Scanlines speed Y;16;0;Create;True;0;0;False;0;-5;-10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-2213.956,1032.947;Float;False;Property;_ScanlinesspeedX;Scanlines speed X;15;0;Create;True;0;0;False;0;-5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;26;-1979.546,1241.96;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;18;-2783.113,1065.958;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-2094.328,1156.449;Float;False;Property;_ScanlinesscaleY;Scanlines scale Y;14;0;Create;True;0;0;False;0;30;12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;-2154.715,1436.934;Float;False;Property;_ScanlinesscaleZ;Scanlines scale Z;12;0;Create;True;0;0;False;0;30;400;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;147;-2001.859,1036.363;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;154;-2039.933,1522.444;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-2116.641,950.8529;Float;False;Property;_ScanlinesscaleX;Scanlines scale X;13;0;Create;True;0;0;False;0;30;800;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;166;-2665.526,1266.198;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;148;-1806.524,784.1814;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-1691.032,287.2283;Float;False;Property;_Globalemissionflickerfreq;Global emission flicker freq;7;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;23;-1817.313,1076.463;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;155;-1811.719,1401.704;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;156;-1607.21,1400.5;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;77;-1894.016,-161.821;Float;False;Property;_Offset;Offset;2;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SinOpNode;17;-1612.806,1075.259;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;149;-1602.017,782.9769;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;99;-1406.959,290.3194;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;144;-1595.863,-287.6119;Float;False;Property;_Tiling;Tiling;1;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;66;-1452.95,22.25289;Float;False;Property;_ScrollingspeedX;Scrolling speed X;21;0;Create;True;0;0;False;0;-1;0.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;80;-1619.355,-155.5489;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;360,360;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;182;-1294.772,-245.1793;Float;False;Property;_RotationSpeed;Rotation Speed;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-1453.462,110.3218;Float;False;Property;_ScrollingspeedY;Scrolling speed Y;22;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;107;-1214.507,289.5719;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;175;-1443.094,1111.609;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;150;-1425.03,807.4247;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-1557.199,397.9157;Float;False;Property;_Globalemissionflickeramplitude;Global emission flicker amplitude;6;0;Create;True;0;0;False;0;0.5;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;157;-1408.393,1417.876;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-1229.02,196.1561;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1249.919,-119.4588;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;70;-1114.849,24.66008;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;185;-1190.13,-371.8804;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;181;-1098.172,-240.9796;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;176;-1247.253,1193.321;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;178;-1201.602,386.0067;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;-1389.357,609.6656;Float;False;Property;_Globalemissionflickeroffset;Global emission flicker offset;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;151;-1229.19,889.1367;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;177;-1036.22,277.1365;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;158;-1232.588,1505.39;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;179;-890.546,-225.9918;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;104;-855.5659,314.0598;Float;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;160;-1071.44,1399.682;Float;False;Property;_SharpZ;SharpZ;19;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;152;-1066.247,782.158;Float;False;Property;_SharpX;SharpX;20;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;4;-917.6037,-5.00495;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;139;-1077.034,1074.44;Float;False;Property;_SharpY;SharpY;18;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;187;-597.6171,-111.9894;Float;False;Property;_Scrollrotate;Scroll rotate;33;0;Create;True;0;0;False;0;0;0;0;True;;KeywordEnum;3;Scroll;Rotate;None;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;153;-844.8987,780.4857;Float;False;Property;_ScanlinesX;Scanlines X;11;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-39.38604,1069.374;Float;False;Property;_Verticalstretchfreq;Vertical stretch freq;25;0;Create;True;0;0;False;0;0.5;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;159;-850.0922,1398.009;Float;False;Property;_ScanlinesZ;Scanlines Z;10;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;118;-572.7116,288.5319;Float;False;Property;_Globalemissionflicker;Global emission flicker;5;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;120;-855.6864,1072.768;Float;False;Property;_ScanlinesY;Scanlines Y;9;0;Create;True;0;0;False;0;0;2;0;FLOAT;1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;163;-2573.871,969.219;Float;False;Vertexpos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;5;-306.6356,-53.55761;Float;True;Property;_Tex;Tex;0;1;[NoScaleOffset];Create;True;0;0;False;0;401b139f4adac8b4e8443cc06789537c;721a2e8a9380bf54bae7bff61327b6d7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-145.8064,289.6003;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;232.1206,1465.092;Float;False;163;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;110;155.1373,750.574;Float;False;Property;_Verticalmovementfreq;Vertical movement freq;30;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;91;187.4477,1073.392;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;111;432.3923,756.3925;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;89;379.4249,1075.576;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;278.2461,1227.986;Float;False;Property;_Verticalstretchoffset;Vertical stretch offset;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;81.73598,156.0522;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;94;199.3306,1151.865;Float;False;Property;_Verticalstretchamplitude;Vertical stretch amplitude;24;0;Create;True;0;0;False;0;0.5;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;165;419.6192,1469.911;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;97;378.8166,1338.964;Float;False;Property;_Verticalstretchpivotpoint;Vertical stretch pivot point;27;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;112;624.3689,758.5767;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;220.754,-231.42;Float;False;Property;_Color;Color;3;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1.208,1.208,1.208,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;113;523.1909,910.9854;Float;False;Property;_Verticalmovementoffset;Vertical movement offset;31;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;93;566.4366,1076.243;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;444.275,834.8658;Float;False;Property;_Verticalmovementamplitude;Vertical movement amplitude;29;0;Create;True;0;0;False;0;0.5;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;98;698.5826,1322.563;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;217.8807,154.0299;Float;True;CombinedTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;183.7671,-488.9116;Float;False;41;0;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;49;487.101,268.3904;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RGBToHSVNode;126;689.2357,-576.2731;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RGBToHSVNode;125;685.0179,-721.8701;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;899.6132,1069.081;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;115;811.3798,759.2436;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;818.1227,-18.85884;Float;False;51;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;1114.021,-614.2165;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;117;1122.52,1042.732;Float;False;Property;_Verticalstretch;Vertical stretch;23;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;116;1025.961,732.4148;Float;False;Property;_Verticalmovement;Vertical movement;28;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;753.2137,333.7381;Float;True;CombinedTexture_alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;1295.025,-218.1408;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;1468.085,864.4153;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;1296.865,-100.6904;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.HSVToRGBNode;127;1306.327,-520.4841;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;86;1664.135,988.5111;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;40;1952.718,-269.5119;Float;True;Property;_Colormode;Color mode;4;0;Create;True;0;0;False;0;0;2;2;True;;KeywordEnum;4;Original;Hueshift;Multiply;Replace;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2368.678,265.2996;Float;False;True;2;Float;TexturePannerEditor;0;0;Standard;AdultLink/TexturePanner;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;26;0;25;0
WireConnection;147;0;145;0
WireConnection;154;0;162;0
WireConnection;148;0;166;1
WireConnection;148;1;146;0
WireConnection;148;2;147;0
WireConnection;23;0;166;2
WireConnection;23;1;24;0
WireConnection;23;2;26;0
WireConnection;155;0;18;3
WireConnection;155;1;161;0
WireConnection;155;2;154;0
WireConnection;156;0;155;0
WireConnection;17;0;23;0
WireConnection;149;0;148;0
WireConnection;99;0;100;0
WireConnection;80;0;77;0
WireConnection;107;0;99;0
WireConnection;175;0;17;0
WireConnection;150;0;149;0
WireConnection;157;0;156;0
WireConnection;7;0;144;0
WireConnection;7;1;80;0
WireConnection;70;0;66;0
WireConnection;70;1;69;0
WireConnection;181;0;182;0
WireConnection;176;0;175;0
WireConnection;178;0;103;0
WireConnection;151;0;150;0
WireConnection;177;0;107;0
WireConnection;158;0;157;0
WireConnection;179;0;185;0
WireConnection;179;2;181;0
WireConnection;104;0;177;0
WireConnection;104;1;178;0
WireConnection;104;2;102;0
WireConnection;160;0;157;0
WireConnection;160;1;158;0
WireConnection;152;0;150;0
WireConnection;152;1;151;0
WireConnection;4;0;7;0
WireConnection;4;2;70;0
WireConnection;4;1;6;0
WireConnection;139;0;175;0
WireConnection;139;1;176;0
WireConnection;187;1;4;0
WireConnection;187;0;179;0
WireConnection;187;2;7;0
WireConnection;153;1;152;0
WireConnection;159;1;160;0
WireConnection;118;1;104;0
WireConnection;120;1;139;0
WireConnection;163;0;18;0
WireConnection;5;1;187;0
WireConnection;108;0;118;0
WireConnection;108;1;153;0
WireConnection;108;2;120;0
WireConnection;108;3;159;0
WireConnection;91;0;83;0
WireConnection;111;0;110;0
WireConnection;89;0;91;0
WireConnection;11;0;5;0
WireConnection;11;1;108;0
WireConnection;165;0;164;0
WireConnection;112;0;111;0
WireConnection;93;0;89;0
WireConnection;93;1;94;0
WireConnection;93;2;95;0
WireConnection;98;0;97;0
WireConnection;98;1;165;1
WireConnection;41;0;11;0
WireConnection;49;0;41;0
WireConnection;126;0;9;0
WireConnection;125;0;42;0
WireConnection;85;0;93;0
WireConnection;85;1;98;0
WireConnection;115;0;112;0
WireConnection;115;1;114;0
WireConnection;115;2;113;0
WireConnection;43;0;125;1
WireConnection;43;1;126;1
WireConnection;117;1;85;0
WireConnection;116;1;115;0
WireConnection;51;0;49;3
WireConnection;8;0;42;0
WireConnection;8;1;9;0
WireConnection;109;0;116;0
WireConnection;109;1;117;0
WireConnection;45;0;9;0
WireConnection;45;1;52;0
WireConnection;127;0;43;0
WireConnection;127;1;125;2
WireConnection;127;2;125;3
WireConnection;86;1;109;0
WireConnection;40;1;42;0
WireConnection;40;0;127;0
WireConnection;40;2;8;0
WireConnection;40;3;45;0
WireConnection;0;2;40;0
WireConnection;0;9;51;0
WireConnection;0;11;86;0
ASEEND*/
//CHKSM=835E80EAA5F797915FF24C115C0C794F9FC6FC1B