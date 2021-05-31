// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_StylizedFlame"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Noise_Tiling("Noise_Tiling", Vector) = (1,1,0,0)
		_Noise_Panning("Noise_Panning", Vector) = (0,0,0,0)
		_Noise_Mult("Noise_Mult", Float) = 1
		_Noise_Power("Noise_Power", Float) = 10.32
		[NoScaleOffset]_FireMasksTexture("FireMasksTexture", 2D) = "white" {}
		[HDR]_CoreColor("CoreColor", Color) = (0,0,0,0)
		[HDR]_MainColor("MainColor", Color) = (0,0,0,0)
		_DistortionAmount("DistortionAmount", Float) = 0
		_VerticalGradientPower("VerticalGradientPower", Float) = 1
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
		uniform float2 _Noise_Panning;
		uniform float2 _Noise_Tiling;
		uniform float _Noise_Power;
		uniform float _Noise_Mult;
		uniform float _DistortionAmount;
		uniform float _VerticalGradientPower;
		uniform float4 _MainColor;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_FireMasksTexture14 = i.uv_texcoord;
			float2 uv_TexCoord1_g2 = i.uv_texcoord * _Noise_Tiling + float2( 0,0 );
			float2 panner4_g2 = ( 1.0 * _Time.y * _Noise_Panning + uv_TexCoord1_g2);
			float4 appendResult18 = (float4(i.uv_texcoord.x , ( ( tex2D( _FireMasksTexture, uv_FireMasksTexture14 ).g * saturate( ( pow( tex2D( _FireMasksTexture, panner4_g2 ).a , _Noise_Power ) * _Noise_Mult ) ) * i.uv_texcoord.y * _DistortionAmount * saturate( pow( ( 1.0 - i.uv_texcoord.y ) , _VerticalGradientPower ) ) ) + i.uv_texcoord.y ) , 0.0 , 0.0));
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
1727;8;1706;1356;-1987.776;828.8989;1;True;True
Node;AmplifyShaderEditor.Vector2Node;4;-989.5,84;Inherit;False;Property;_Noise_Tiling;Noise_Tiling;1;0;Create;True;0;0;False;0;False;1,1;0.26,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;5;-996.5,228;Inherit;False;Property;_Noise_Panning;Noise_Panning;2;0;Create;True;0;0;False;0;False;0,0;0,-0.23;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;13;-819.9591,-304.667;Inherit;True;Property;_FireMasksTexture;FireMasksTexture;5;1;[NoScaleOffset];Create;True;0;0;False;0;False;98ffcba14922add4d96fd60028011385;98ffcba14922add4d96fd60028011385;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;40;-729.5,129;Inherit;False;SF_TilingOffsetPanner;-1;;2;48438e994d3957a45811bd34739ee955;0;3;6;FLOAT2;1,1;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-419.5,101;Inherit;True;Property;_FireMasks;FireMasks;1;0;Create;True;0;0;False;0;False;-1;98ffcba14922add4d96fd60028011385;98ffcba14922add4d96fd60028011385;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-238.4694,364.8694;Inherit;False;Property;_Noise_Power;Noise_Power;4;0;Create;True;0;0;False;0;False;10.32;2.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;422.6239,346.5403;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;544.1592,615.7353;Inherit;False;Property;_VerticalGradientPower;VerticalGradientPower;9;0;Create;True;0;0;False;0;False;1;2.42;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;25.53064,364.8694;Inherit;False;Property;_Noise_Mult;Noise_Mult;3;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;6;-23.46936,214.8694;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;38;640.3593,544.2353;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;192.5306,210.8694;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;35;826.259,541.6351;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;440.6088,483.8733;Inherit;False;Property;_DistortionAmount;DistortionAmount;8;0;Create;True;0;0;False;0;False;0;4.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;173.0168,-281.287;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;36;993.9592,542.9352;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;8;361.5306,208.8694;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;802.2163,51.5131;Inherit;True;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;34;1323.515,314.1865;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;1246.102,53.39114;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;1462.232,36.53712;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;19;1620.546,39.66333;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;21;1792,-304;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;23;2048,-496;Inherit;False;Property;_CoreColor;CoreColor;6;1;[HDR];Create;True;0;0;False;0;False;0,0,0,0;1.701961,1.380392,0.1411765,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;32;2096,-32;Inherit;False;Property;_MainColor;MainColor;7;1;[HDR];Create;True;0;0;False;0;False;0,0,0,0;4.594794,0.04452984,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;2560,-304;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;2528,-112;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;43;2743.496,81.96948;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;44;2972.776,134.1011;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;2736,-176;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;3093.776,-1.898926;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3218.031,-235.1083;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;S_StylizedFlame;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;6;4;0
WireConnection;40;8;5;0
WireConnection;2;0;13;0
WireConnection;2;1;40;0
WireConnection;6;0;2;4
WireConnection;6;1;9;0
WireConnection;38;0;16;2
WireConnection;7;0;6;0
WireConnection;7;1;10;0
WireConnection;35;0;38;0
WireConnection;35;1;37;0
WireConnection;14;0;13;0
WireConnection;36;0;35;0
WireConnection;8;0;7;0
WireConnection;15;0;14;2
WireConnection;15;1;8;0
WireConnection;15;2;16;2
WireConnection;15;3;31;0
WireConnection;15;4;36;0
WireConnection;34;0;16;1
WireConnection;20;0;15;0
WireConnection;20;1;16;2
WireConnection;18;0;34;0
WireConnection;18;1;20;0
WireConnection;19;0;18;0
WireConnection;21;0;13;0
WireConnection;21;1;19;0
WireConnection;24;0;23;0
WireConnection;24;1;21;1
WireConnection;26;0;21;3
WireConnection;26;1;32;0
WireConnection;44;0;43;2
WireConnection;27;0;24;0
WireConnection;27;1;26;0
WireConnection;45;0;27;0
WireConnection;45;1;44;0
WireConnection;0;2;27;0
WireConnection;0;10;45;0
ASEEND*/
//CHKSM=65AEAB819F117B00CA659B2C97117DCA7332FEF2