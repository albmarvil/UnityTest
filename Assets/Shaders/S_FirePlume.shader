// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_FirePlume"
{
	Properties
	{
		_Texture1("Texture 1", 2D) = "white" {}
		_XFrames("XFrames", Float) = 4
		_YFrames("YFrames", Float) = 4
		_PlayRate("PlayRate", Float) = 1
		_VelCeil("VelCeil", Float) = 0.5
		_VelFloor("VelFloor", Float) = 0.5
		_VelocityStrength("VelocityStrength", Float) = 0.5
		[HDR]_FireColor("FireColor", Color) = (1,0.4846769,0,0)
		[HDR]_LightColor("LightColor", Color) = (1024,1024,1024,0)
		_DarkColor("DarkColor", Color) = (0,0,0,0)
		_DensityPow("DensityPow", Float) = 1
		_TimeOffset("TimeOffset", Float) = 0
		_TimeRangeDilation("TimeRangeDilation", Float) = 1
		_VerticalFade("VerticalFade", Float) = 1
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv_tex4coord;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float4 _DarkColor;
		uniform float4 _LightColor;
		uniform sampler2D _Texture1;
		uniform float _TimeRangeDilation;
		uniform float _TimeOffset;
		uniform float _PlayRate;
		uniform float _XFrames;
		uniform float _YFrames;
		uniform float _VelocityStrength;
		uniform float _VelFloor;
		uniform float _VelCeil;
		uniform float _DensityPow;
		uniform float4 _FireColor;
		uniform float _VerticalFade;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float CustomTime163_g75 = ( ( i.uv_tex4coord.z * _TimeRangeDilation ) + _TimeOffset );
			float PlaySpeed162_g75 = _PlayRate;
			float temp_output_26_0_g75 = ( CustomTime163_g75 * PlaySpeed162_g75 );
			float HorizontalSubImages165_g75 = _XFrames;
			float temp_output_22_0_g75 = ( 1.0 / HorizontalSubImages165_g75 );
			float VerticalSubImages164_g75 = _YFrames;
			float temp_output_33_0_g75 = ( 1.0 / VerticalSubImages164_g75 );
			float4 appendResult13_g75 = (float4(( floor( ( frac( temp_output_26_0_g75 ) * HorizontalSubImages165_g75 ) ) * temp_output_22_0_g75 ) , ( 1.0 - ( floor( ( frac( ( temp_output_33_0_g75 * temp_output_26_0_g75 ) ) * VerticalSubImages164_g75 ) ) * temp_output_33_0_g75 ) ) , 0.0 , 0.0));
			float4 appendResult42_g75 = (float4(temp_output_22_0_g75 , temp_output_33_0_g75 , 0.0 , 0.0));
			float2 temp_output_38_0_g75 = ( i.uv_texcoord * (appendResult42_g75).xy );
			float2 temp_output_11_0_g75 = ( (appendResult13_g75).xy + temp_output_38_0_g75 );
			float2 temp_cast_0 = (1.0).xx;
			float2 temp_output_10_0_g75 = ( ( temp_output_11_0_g75 * 2.0 ) - temp_cast_0 );
			float2 temp_cast_1 = (1.0).xx;
			float4 tex2DNode45_g75 = tex2D( _Texture1, temp_output_11_0_g75 );
			float4 appendResult185_g75 = (float4(tex2DNode45_g75.r , 0.0 , 0.0 , 0.0));
			float2 temp_output_53_0_g75 = (appendResult185_g75).xy;
			float2 temp_cast_2 = (1.0).xx;
			float2 temp_output_56_0_g75 = ( ( ( ( ( pow( tex2D( _Texture1, temp_output_11_0_g75 ).g , 0.25 ) * _VelocityStrength ) + ( PlaySpeed162_g75 * _VelFloor ) ) * ( ( 1.0 / PlaySpeed162_g75 ) * 0.5 ) ) * ( ( 1.0 / ( max( _PlayRate , 0.5 ) + 0.5 ) ) * ( min( _PlayRate , 0.5 ) * 0.5 ) ) ) * temp_output_38_0_g75 );
			float VelStrengthCap154_g75 = _VelCeil;
			float temp_output_78_0_g75 = ( ( 1.0 - frac( ( HorizontalSubImages165_g75 * temp_output_26_0_g75 ) ) ) * VelStrengthCap154_g75 );
			float2 lerpResult7_g75 = lerp( temp_output_10_0_g75 , ( temp_output_10_0_g75 + ( ( ( temp_output_53_0_g75 * 2.0 ) - temp_cast_2 ) * temp_output_56_0_g75 ) ) , temp_output_78_0_g75);
			float temp_output_130_0_g75 = ( temp_output_26_0_g75 + ( temp_output_22_0_g75 * -1.0 ) );
			float4 appendResult112_g75 = (float4(( floor( ( frac( temp_output_130_0_g75 ) * HorizontalSubImages165_g75 ) ) * temp_output_22_0_g75 ) , ( 1.0 - ( floor( ( frac( ( temp_output_130_0_g75 * temp_output_33_0_g75 ) ) * VerticalSubImages164_g75 ) ) * temp_output_33_0_g75 ) ) , 0.0 , 0.0));
			float2 temp_cast_3 = (1.0).xx;
			float2 temp_output_90_0_g75 = ( ( ( (appendResult112_g75).xy + temp_output_38_0_g75 ) * 2.0 ) - temp_cast_3 );
			float2 temp_cast_4 = (1.0).xx;
			float2 temp_cast_5 = (1.0).xx;
			float2 lerpResult88_g75 = lerp( temp_output_90_0_g75 , ( temp_output_90_0_g75 + ( temp_output_56_0_g75 * ( ( ( 1.0 - temp_output_53_0_g75 ) * 2.0 ) - temp_cast_5 ) ) ) , ( frac( ( temp_output_130_0_g75 * HorizontalSubImages165_g75 ) ) * VelStrengthCap154_g75 ));
			float4 lerpResult1_g75 = lerp( tex2D( _Texture1, ( ( lerpResult7_g75 + 1.0 ) * 0.5 ) ) , tex2D( _Texture1, ( ( lerpResult88_g75 + 1.0 ) * 0.5 ) ) , ( ( 1.0 / VelStrengthCap154_g75 ) * temp_output_78_0_g75 ));
			float4 break59 = lerpResult1_g75;
			float4 lerpResult94 = lerp( _DarkColor , _LightColor , pow( break59.g , _DensityPow ));
			o.Emission = ( lerpResult94 + ( break59.b * _FireColor ) ).rgb;
			float lerpResult126 = lerp( 1.0 , pow( i.uv_texcoord.y , _VerticalFade ) , i.uv_tex4coord.z);
			o.Alpha = ( break59.a * i.vertexColor.a * lerpResult126 );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float2 customPack2 : TEXCOORD2;
				float3 worldPos : TEXCOORD3;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xyzw = customInputData.uv_tex4coord;
				o.customPack1.xyzw = v.texcoord;
				o.customPack2.xy = customInputData.uv_texcoord;
				o.customPack2.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_tex4coord = IN.customPack1.xyzw;
				surfIN.uv_texcoord = IN.customPack2.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.vertexColor = IN.color;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1730;1;1707;1374;-86.97377;1039.866;2.321101;True;True
Node;AmplifyShaderEditor.CommentaryNode;104;-81.45401,654.9471;Inherit;False;784.795;363.9984;Vel Strength play rate dependent;6;78;79;82;83;80;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-238.5219,342.6668;Inherit;False;Property;_PlayRate;PlayRate;3;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;120;900.0688,811.85;Inherit;False;755.7448;374.1107;Custom particle time;5;115;114;113;112;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;78;-27.61849,726.6827;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;1082.529,1069.961;Inherit;False;Property;_TimeRangeDilation;TimeRangeDilation;14;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;108;950.0688,861.85;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;79;156.4942,727.9612;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;82;-31.45401,883.9455;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;147.5444,881.3884;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;80;321.4283,704.9471;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;1288.256,912.926;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;1431.36,1052.881;Inherit;False;Property;_TimeOffset;TimeOffset;13;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;541.3411,765.0396;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;112;1503.814,912.8718;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;615.457,61.52812;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;990.0609,572.6798;Inherit;False;Property;_VelocityStrength;VelocityStrength;6;0;Create;True;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;671.457,-97.47185;Inherit;False;Property;_XFrames;XFrames;1;0;Create;True;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;1010.911,399.4514;Inherit;False;Property;_VelCeil;VelCeil;4;0;Create;True;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;668.457,-16.47184;Inherit;False;Property;_YFrames;YFrames;2;0;Create;True;0;0;False;0;False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;1009.911,473.4514;Inherit;False;Property;_VelFloor;VelFloor;5;0;Create;True;0;0;False;0;False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;63;583.4571,181.5281;Inherit;True;Property;_Texture1;Texture 1;0;0;Create;True;0;0;False;0;False;841bb6cad6ab7744b922d1654e1d6b60;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;119;942.4454,100.7482;Inherit;False;SF_AdvancedFlipbookPlayer;7;;75;32aedb6b772e9b341a98123cbcce2384;0;10;176;FLOAT;4;False;177;FLOAT;4;False;40;FLOAT2;0,0;False;167;SAMPLER2D;;False;23;FLOAT;0;False;161;FLOAT;1;False;70;FLOAT;0.5;False;153;FLOAT;0.5;False;66;FLOAT;0.5;False;65;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;99;1481.46,-67.42824;Inherit;False;Property;_DensityPow;DensityPow;12;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;59;1345.457,96.52809;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TextureCoordinatesNode;121;2156.304,1293.99;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;128;2060.158,1627.325;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;2426.389,1518.554;Inherit;False;Property;_VerticalFade;VerticalFade;15;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;97;1758.281,-302.934;Inherit;False;Property;_LightColor;LightColor;10;1;[HDR];Create;True;0;0;False;0;False;1024,1024,1024,0;0.7924528,0.7924528,0.7924528,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;96;1774.809,-490.9254;Inherit;False;Property;_DarkColor;DarkColor;11;0;Create;True;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;98;1770.677,-9.584717;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;2746.957,1237.135;Inherit;False;Constant;_Float0;Float 0;15;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;122;2549.472,1342.012;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;129;2830.762,1587.869;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;102;1962.8,155.6826;Inherit;False;Property;_FireColor;FireColor;9;1;[HDR];Create;True;0;0;False;0;False;1,0.4846769,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;116;2511.36,913.1417;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;2156.989,17.27124;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;94;2101.211,-315.329;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;126;2934.967,1248.097;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;106;2652.168,739.4902;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;2729.563,776.1323;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;65;614.457,388.5283;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;100;2526.774,-313.2631;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3316.672,497.7831;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;S_FirePlume;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;78;0;66;0
WireConnection;79;0;78;0
WireConnection;82;0;66;0
WireConnection;83;0;82;0
WireConnection;80;1;79;0
WireConnection;114;0;108;3
WireConnection;114;1;115;0
WireConnection;81;0;80;0
WireConnection;81;1;83;0
WireConnection;112;0;114;0
WireConnection;112;1;113;0
WireConnection;119;176;60;0
WireConnection;119;177;61;0
WireConnection;119;40;62;0
WireConnection;119;167;63;0
WireConnection;119;23;112;0
WireConnection;119;161;66;0
WireConnection;119;70;81;0
WireConnection;119;153;68;0
WireConnection;119;66;69;0
WireConnection;119;65;70;0
WireConnection;59;0;119;0
WireConnection;128;0;108;3
WireConnection;98;0;59;1
WireConnection;98;1;99;0
WireConnection;122;0;121;2
WireConnection;122;1;123;0
WireConnection;129;0;128;0
WireConnection;101;0;59;2
WireConnection;101;1;102;0
WireConnection;94;0;96;0
WireConnection;94;1;97;0
WireConnection;94;2;98;0
WireConnection;126;0;127;0
WireConnection;126;1;122;0
WireConnection;126;2;129;0
WireConnection;106;0;59;3
WireConnection;107;0;106;0
WireConnection;107;1;116;4
WireConnection;107;2;126;0
WireConnection;100;0;94;0
WireConnection;100;1;101;0
WireConnection;0;2;100;0
WireConnection;0;9;107;0
ASEEND*/
//CHKSM=A5FDB072A8FA839F1FA45F0882E142EB8954E494