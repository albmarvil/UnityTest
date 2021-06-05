// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_Test"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Pow("Pow", Float) = 1
		_Mult("Mult", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		SamplerState sampler_TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Pow;
		uniform float _Mult;


		float2 Unpack2ChannelInfo2_g11( float velocity )
		{
			int v = velocity * 255;
			int b = v & 15;
			float B = b * 2;
			int a = v & 240;
			a = a >> 4;
			float A = a *2;
			return float2(A,B) / 255;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float velocity2_g11 = tex2D( _TextureSample0, uv_TextureSample0 ).r;
			float2 localUnpack2ChannelInfo2_g11 = Unpack2ChannelInfo2_g11( velocity2_g11 );
			float2 temp_cast_0 = (_Pow).xx;
			float2 temp_output_17_0 = saturate( ( pow( localUnpack2ChannelInfo2_g11 , temp_cast_0 ) * _Mult ) );
			o.Emission = float3( temp_output_17_0 ,  0.0 );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1725;1;1712;1374;1118;587;1;True;True
Node;AmplifyShaderEditor.SamplerNode;1;-657,-20;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;False;-1;1ea601371b924744880d969a89dc28ef;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-598,207;Inherit;False;Property;_Pow;Pow;1;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-553,327;Inherit;False;Property;_Mult;Mult;2;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;17;-329,8;Inherit;False;SF_UnpackVelocityMap;-1;;11;3855d51d127728e439acd28721dc9273;0;3;1;FLOAT;0;False;6;FLOAT;1;False;7;FLOAT;4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-30,103;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;241,-39;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;S_Test;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;17;1;1;1
WireConnection;17;6;15;0
WireConnection;17;7;16;0
WireConnection;10;0;17;0
WireConnection;0;2;17;0
ASEEND*/
//CHKSM=DA5D0C9FB590D4DE9D7532C688BAECD7AAD1B668