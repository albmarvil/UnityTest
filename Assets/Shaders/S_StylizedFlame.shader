// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_StylizedFlame"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_VNoise_Tiling("VNoise_Tiling", Vector) = (1,1,0,0)
		_HNoise_Tiling("HNoise_Tiling", Vector) = (1,1,0,0)
		_VNoise_Panning("VNoise_Panning", Vector) = (0,0,0,0)
		_HNoise_Panning("HNoise_Panning", Vector) = (0,0,0,0)
		_VNoise_Mult("VNoise_Mult", Float) = 1
		_HNoise_Mult("HNoise_Mult", Float) = 1
		_VNoise_Power("VNoise_Power", Float) = 10.32
		_HNoise_Power("HNoise_Power", Float) = 10.32
		[NoScaleOffset]_FireMasksTexture("FireMasksTexture", 2D) = "white" {}
		[HDR]_CoreColor("CoreColor", Color) = (0,0,0,0)
		[HDR]_MainColor("MainColor", Color) = (0,0,0,0)
		_VDistortionAmount("VDistortionAmount", Float) = 0
		_HDistortionAmount("HDistortionAmount", Float) = 0
		_VDistortion_GradientMaskPower("VDistortion_GradientMaskPower", Float) = 1
		_Float0("Float 0", Float) = 1
		_HDistortion_OscilationFreq("HDistortion_OscilationFreq", Float) = 0.25
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _CoreColor;
		uniform sampler2D _FireMasksTexture;
		uniform float2 _HNoise_Panning;
		uniform float2 _HNoise_Tiling;
		uniform float _HNoise_Power;
		uniform float _HNoise_Mult;
		uniform float _VDistortion_GradientMaskPower;
		uniform float _Float0;
		uniform float _HDistortionAmount;
		uniform float _HDistortion_OscilationFreq;
		uniform float2 _VNoise_Panning;
		uniform float2 _VNoise_Tiling;
		uniform float _VNoise_Power;
		uniform float _VNoise_Mult;
		uniform float _VDistortionAmount;
		uniform float4 _MainColor;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_FireMasksTexture14 = i.uv_texcoord;
			float4 tex2DNode14 = tex2D( _FireMasksTexture, uv_FireMasksTexture14 );
			float2 uv_TexCoord1_g3 = i.uv_texcoord * _HNoise_Tiling + float2( 0,0 );
			float2 panner4_g3 = ( 1.0 * _Time.y * _HNoise_Panning + uv_TexCoord1_g3);
			float temp_output_36_0 = saturate( pow( ( 1.0 - i.uv_texcoord.y ) , _VDistortion_GradientMaskPower ) );
			float mulTime73 = _Time.y * _HDistortion_OscilationFreq;
			float2 uv_TexCoord1_g2 = i.uv_texcoord * _VNoise_Tiling + float2( 0,0 );
			float2 panner4_g2 = ( 1.0 * _Time.y * _VNoise_Panning + uv_TexCoord1_g2);
			float4 appendResult18 = (float4(( ( tex2DNode14.g * saturate( ( pow( tex2D( _FireMasksTexture, panner4_g3 ).a , _HNoise_Power ) * _HNoise_Mult ) ) * temp_output_36_0 * saturate( pow( i.uv_texcoord.y , _Float0 ) ) * ( _HDistortionAmount * sin( mulTime73 ) ) ) + i.uv_texcoord.x ) , ( ( tex2DNode14.g * saturate( ( pow( tex2D( _FireMasksTexture, panner4_g2 ).a , _VNoise_Power ) * _VNoise_Mult ) ) * i.uv_texcoord.y * _VDistortionAmount * temp_output_36_0 ) + i.uv_texcoord.y ) , 0.0 , 0.0));
			float4 tex2DNode21 = tex2D( _FireMasksTexture, (appendResult18).xy );
			float4 temp_output_27_0 = ( ( _CoreColor * tex2DNode21.r ) + ( tex2DNode21.b * _MainColor ) );
			o.Emission = temp_output_27_0.rgb;
			o.Alpha = 1;
			clip( ( temp_output_27_0 * ( 1.0 - i.uv_texcoord.y ) ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1727;8;1706;1356;-2045.725;701.3581;1.276749;True;True
Node;AmplifyShaderEditor.CommentaryNode;63;-1821.934,941.1565;Inherit;False;1662.734;439.9072;Horizontal Noise;9;49;46;47;48;53;54;55;56;52;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;62;-1904.573,13.76549;Inherit;False;1569.446;430.5961;Vertical Noise ;9;2;40;4;5;6;7;8;9;10;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;47;-1764.934,991.1565;Inherit;False;Property;_HNoise_Tiling;HNoise_Tiling;2;0;Create;True;0;0;False;0;False;1,1;0.1,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;5;-1854.573,207.7654;Inherit;False;Property;_VNoise_Panning;VNoise_Panning;3;0;Create;True;0;0;False;0;False;0,0;0,-0.25;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;4;-1847.573,63.76549;Inherit;False;Property;_VNoise_Tiling;VNoise_Tiling;1;0;Create;True;0;0;False;0;False;1,1;0.26,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;48;-1771.934,1135.157;Inherit;False;Property;_HNoise_Panning;HNoise_Panning;4;0;Create;True;0;0;False;0;False;0,0;0.2,-0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;49;-1504.934,1036.157;Inherit;False;SF_TilingOffsetPanner;-1;;3;48438e994d3957a45811bd34739ee955;0;3;6;FLOAT2;1,1;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;40;-1587.573,108.7655;Inherit;False;SF_TilingOffsetPanner;-1;;2;48438e994d3957a45811bd34739ee955;0;3;6;FLOAT2;1,1;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;13;-1894.844,-292.2864;Inherit;True;Property;_FireMasksTexture;FireMasksTexture;9;1;[NoScaleOffset];Create;True;0;0;False;0;False;98ffcba14922add4d96fd60028011385;98ffcba14922add4d96fd60028011385;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;61;-40.24447,-147.6044;Inherit;False;1428.546;958.9595;Vertical Distortion;9;14;16;31;36;35;37;15;20;70;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;64;6.032837,1028.337;Inherit;False;1500.01;1034.523;Horizontal Distortion;11;58;60;57;69;68;59;66;73;74;75;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1100.128,328.3616;Inherit;False;Property;_VNoise_Power;VNoise_Power;7;0;Create;True;0;0;False;0;False;10.32;2.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-924.2002,1257.752;Inherit;False;Property;_HNoise_Power;HNoise_Power;8;0;Create;True;0;0;False;0;False;10.32;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1277.573,80.76549;Inherit;True;Property;_FireMasks;FireMasks;1;0;Create;True;0;0;False;0;False;-1;98ffcba14922add4d96fd60028011385;98ffcba14922add4d96fd60028011385;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;9.755531,374.5748;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;-1194,1007.895;Inherit;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;False;0;False;-1;98ffcba14922add4d96fd60028011385;98ffcba14922add4d96fd60028011385;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;74;19.52393,1931.298;Inherit;False;Property;_HDistortion_OscilationFreq;HDistortion_OscilationFreq;16;0;Create;True;0;0;False;0;False;0.25;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;73;287.6413,1931.298;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;38.63019,1542.445;Inherit;False;Property;_Float0;Float 0;15;0;Create;True;0;0;False;0;False;1;3.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;59;48.84424,1301.176;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-836.1272,328.3616;Inherit;False;Property;_VNoise_Mult;VNoise_Mult;5;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;53;-709.2,1107.751;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;70;192.4572,536.3803;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-688.2295,1265.064;Inherit;False;Property;_HNoise_Mult;HNoise_Mult;6;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;131.2908,643.7698;Inherit;False;Property;_VDistortion_GradientMaskPower;VDistortion_GradientMaskPower;14;0;Create;True;0;0;False;0;False;1;2.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;6;-885.1273,178.3616;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;75;468.9394,1935.128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;39.85062,1788.04;Inherit;False;Property;_HDistortionAmount;HDistortionAmount;13;0;Create;True;0;0;False;0;False;0;22.54;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;35;413.3903,569.6696;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-493.2004,1103.751;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;68;523.2872,1455.024;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-669.1277,174.3616;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;55;-324.2,1101.751;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;229.1387,-97.60439;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;69;698.1323,1461.158;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;604.2749,1802.347;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;31.66753,268.4262;Inherit;False;Property;_VDistortionAmount;VDistortionAmount;12;0;Create;True;0;0;False;0;False;0;4.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;8;-500.1277,172.3616;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;36;581.0906,570.9697;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;802.2163,51.5131;Inherit;True;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;835.7738,1078.337;Inherit;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;1835.185,43.46886;Inherit;False;431.314;233;Distorted UVs;2;18;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;1375.515,1079.413;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;1246.102,53.39114;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;1885.185,93.46886;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;19;2043.499,96.59507;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;51;336.7406,-391.5784;Inherit;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ColorNode;23;2625.905,-526.8606;Inherit;False;Property;_CoreColor;CoreColor;10;1;[HDR];Create;True;0;0;False;0;False;0,0,0,0;5.992157,4.862745,0.5019608,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;21;2500.212,-305.6869;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;32;2642.785,-33.68682;Inherit;False;Property;_MainColor;MainColor;11;1;[HDR];Create;True;0;0;False;0;False;0,0,0,0;2,0.1875598,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;3028.978,139.2045;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;2885.065,-334.8606;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;2853.065,-142.8606;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;3061.065,-206.8606;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;80;3298.216,189.8126;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;3418.841,-32.75954;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3640.077,-248.7227;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;S_StylizedFlame;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;49;6;47;0
WireConnection;49;8;48;0
WireConnection;40;6;4;0
WireConnection;40;8;5;0
WireConnection;2;0;13;0
WireConnection;2;1;40;0
WireConnection;46;0;13;0
WireConnection;46;1;49;0
WireConnection;73;0;74;0
WireConnection;53;0;46;4
WireConnection;53;1;56;0
WireConnection;70;0;16;2
WireConnection;6;0;2;4
WireConnection;6;1;9;0
WireConnection;75;0;73;0
WireConnection;35;0;70;0
WireConnection;35;1;37;0
WireConnection;54;0;53;0
WireConnection;54;1;52;0
WireConnection;68;0;59;2
WireConnection;68;1;66;0
WireConnection;7;0;6;0
WireConnection;7;1;10;0
WireConnection;55;0;54;0
WireConnection;14;0;13;0
WireConnection;69;0;68;0
WireConnection;76;0;58;0
WireConnection;76;1;75;0
WireConnection;8;0;7;0
WireConnection;36;0;35;0
WireConnection;15;0;14;2
WireConnection;15;1;8;0
WireConnection;15;2;16;2
WireConnection;15;3;31;0
WireConnection;15;4;36;0
WireConnection;57;0;14;2
WireConnection;57;1;55;0
WireConnection;57;2;36;0
WireConnection;57;3;69;0
WireConnection;57;4;76;0
WireConnection;60;0;57;0
WireConnection;60;1;59;1
WireConnection;20;0;15;0
WireConnection;20;1;16;2
WireConnection;18;0;60;0
WireConnection;18;1;20;0
WireConnection;19;0;18;0
WireConnection;51;0;13;0
WireConnection;21;0;51;0
WireConnection;21;1;19;0
WireConnection;24;0;23;0
WireConnection;24;1;21;1
WireConnection;26;0;21;3
WireConnection;26;1;32;0
WireConnection;27;0;24;0
WireConnection;27;1;26;0
WireConnection;80;0;43;2
WireConnection;45;0;27;0
WireConnection;45;1;80;0
WireConnection;0;2;27;0
WireConnection;0;10;45;0
ASEEND*/
//CHKSM=0A020E10B1B024E62A3E61FF5027D1C10E3A18E6