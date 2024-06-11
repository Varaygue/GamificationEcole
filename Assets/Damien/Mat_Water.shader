// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mat_Water"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _EdgeLength;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float4 appendResult8 = (float4(0.5 , 0.5 , 0.0 , 0.0));
			float2 uv_TexCoord3 = v.texcoord.xy + ( _Time.y + appendResult8 ).xy;
			float simplePerlin2D1 = snoise( uv_TexCoord3*1.8 );
			simplePerlin2D1 = simplePerlin2D1*0.5 + 0.5;
			float3 temp_cast_1 = (( ( simplePerlin2D1 * 1.0 ) + 0.0 )).xxx;
			v.vertex.xyz += temp_cast_1;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color15 = IsGammaSpace() ? float4(0,0.5643754,1,0) : float4(0,0.2785375,1,0);
			float4 appendResult8 = (float4(0.5 , 0.5 , 0.0 , 0.0));
			float2 uv_TexCoord3 = i.uv_texcoord + ( _Time.y + appendResult8 ).xy;
			float simplePerlin2D1 = snoise( uv_TexCoord3*1.8 );
			simplePerlin2D1 = simplePerlin2D1*0.5 + 0.5;
			float smoothstepResult23 = smoothstep( 0.01 , 0.2 , simplePerlin2D1);
			float4 color38 = IsGammaSpace() ? float4(0,0.3719675,0.6509434,0) : float4(0,0.1140622,0.3812781,0);
			float4 color44 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			o.Albedo = ( ( color15 * smoothstepResult23 ) + ( color38 * ( 1.0 - smoothstepResult23 ) ) + ( color44 * step( 0.9 , simplePerlin2D1 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18912
-22.66667;517.3334;1706.667;405;915.564;547.8247;1.739699;True;True
Node;AmplifyShaderEditor.RangedFloatNode;9;-1411.333,155.1667;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1455.333,225.1667;Inherit;False;Constant;_Float2;Float 2;0;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-1260.333,64.16672;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1209.333,180.1667;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-1057.333,107.1667;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-897.3334,-8.833344;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-799.3334,150.1667;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;0;False;0;False;1.8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1;-613.3838,85.91415;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-205.1152,-209.3202;Inherit;False;Constant;_Float5;Float 5;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-241.1152,-306.32;Inherit;False;Constant;_Float4;Float 4;1;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;23;-103.5899,-332.9671;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-198.2494,119.2377;Inherit;False;Constant;_Float7;Float 7;1;0;Create;True;0;0;0;False;0;False;0.9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;38;-458.2506,-286.9464;Inherit;False;Constant;_Color1;Color 0;0;0;Create;True;0;0;0;False;0;False;0,0.3719675,0.6509434,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;42;-1.24939,20.23769;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-420.4174,387.8769;Inherit;False;Constant;_Float3;Float 3;0;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-549.7787,-379.2349;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0,0.5643754,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;44;-103.1248,-134.3563;Inherit;False;Constant;_Color2;Color 0;0;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;32;196.9882,-295.6384;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;370.1283,-549.9984;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-261.1686,234.8033;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-40.79224,389.1854;Inherit;False;Constant;_Float6;Float 6;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;382.2046,-349.3332;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;237.8561,10.03854;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;610.0942,-448.8534;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;227.3461,281.6508;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1007.278,-146.9206;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Mat_Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;9;0
WireConnection;8;1;10;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;3;1;7;0
WireConnection;1;0;3;0
WireConnection;1;1;5;0
WireConnection;23;0;1;0
WireConnection;23;1;24;0
WireConnection;23;2;25;0
WireConnection;42;0;43;0
WireConnection;42;1;1;0
WireConnection;32;0;23;0
WireConnection;11;0;15;0
WireConnection;11;1;23;0
WireConnection;17;0;1;0
WireConnection;17;1;18;0
WireConnection;33;0;38;0
WireConnection;33;1;32;0
WireConnection;45;0;44;0
WireConnection;45;1;42;0
WireConnection;35;0;11;0
WireConnection;35;1;33;0
WireConnection;35;2;45;0
WireConnection;36;0;17;0
WireConnection;36;1;37;0
WireConnection;0;0;35;0
WireConnection;0;11;36;0
ASEEND*/
//CHKSM=911E1B53A5105214FD8B57ECDD49C8722599C60C