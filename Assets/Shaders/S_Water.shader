// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_Water"
{
	Properties
	{
		_DepthFade("DepthFade", Float) = 20
		_Opacity("Opacity", Float) = 20
		_Color0("Color 0", Color) = (0,0,0,0)
		_Float0("Float 0", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_Panning("Panning", Vector) = (0,0,0,0)
		_Tiling("Tiling", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float2 _Panning;
		uniform float2 _Tiling;
		uniform float4 _Color0;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _DepthFade;
		uniform float _Float0;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord17 = i.uv_texcoord * _Tiling;
			float2 panner15 = ( 1.0 * _Time.y * _Panning + uv_TexCoord17);
			o.Normal = UnpackNormal( tex2D( _TextureSample0, panner15 ) );
			o.Albedo = _Color0.rgb;
			float4 color20 = IsGammaSpace() ? float4(0,0.5188679,0.3179383,0) : float4(0,0.2319225,0.08243715,0);
			float4 color21 = IsGammaSpace() ? float4(0.4339623,0.3688753,0.09620862,0) : float4(0.1579265,0.1120897,0.009444472,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth1 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth1 = abs( ( screenDepth1 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFade ) );
			float temp_output_10_0 = saturate( pow( ( 1.0 - distanceDepth1 ) , _Float0 ) );
			float4 lerpResult19 = lerp( color20 , color21 , temp_output_10_0);
			o.Emission = lerpResult19.rgb;
			o.Metallic = 0.0;
			o.Smoothness = 1.0;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

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
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
				float4 tSpace0 : TEXCOORD4;
				float4 tSpace1 : TEXCOORD5;
				float4 tSpace2 : TEXCOORD6;
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
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
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
1720;8;1713;1356;2267.418;1455.453;2.536667;True;True
Node;AmplifyShaderEditor.RangedFloatNode;2;-1823.831,10.76204;Inherit;False;Property;_DepthFade;DepthFade;0;0;Create;True;0;0;False;0;False;20;2.94;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;1;-1584.758,-19.80124;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;8;-1308.758,-13.80124;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1262.758,81.19881;Inherit;False;Property;_Float0;Float 0;3;0;Create;True;0;0;False;0;False;0;34.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;18;-2261.908,538.8283;Inherit;False;Property;_Tiling;Tiling;6;0;Create;True;0;0;False;0;False;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-2022.039,522.9258;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;16;-1763.616,672.6785;Inherit;False;Property;_Panning;Panning;5;0;Create;True;0;0;False;0;False;0,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PowerNode;9;-1142.36,-16.87402;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;-1070.514,-464.3822;Inherit;False;Constant;_BaseColor;BaseColor;7;0;Create;True;0;0;False;0;False;0,0.5188679,0.3179383,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;15;-1580.733,552.0811;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;21;-1069.188,-268.2458;Inherit;False;Constant;_BorderFoamColor;BorderFoamColor;7;0;Create;True;0;0;False;0;False;0.4339623,0.3688753,0.09620862,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;10;-967.7582,-25.80123;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-1122.331,532.536;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;False;0;False;-1;9f8593fd9041ea24db35d568141bb8c9;9f8593fd9041ea24db35d568141bb8c9;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;69.19809,-203.3087;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-20.91859,-300.0517;Inherit;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;142,454;Inherit;False;Property;_Opacity;Opacity;1;0;Create;True;0;0;False;0;False;20;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;6;-859.7581,119.1988;Inherit;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;False;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-633.3403,-45.64582;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;19;-757.756,-239.0903;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;5;-407.92,-468.9919;Inherit;False;Property;_Color0;Color 0;2;0;Create;True;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;62.28654,-3.975765;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;S_Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;0;2;0
WireConnection;8;0;1;0
WireConnection;17;0;18;0
WireConnection;9;0;8;0
WireConnection;9;1;11;0
WireConnection;15;0;17;0
WireConnection;15;2;16;0
WireConnection;10;0;9;0
WireConnection;12;1;15;0
WireConnection;7;0;10;0
WireConnection;7;1;6;0
WireConnection;19;0;20;0
WireConnection;19;1;21;0
WireConnection;19;2;10;0
WireConnection;0;0;5;0
WireConnection;0;1;12;0
WireConnection;0;2;19;0
WireConnection;0;3;14;0
WireConnection;0;4;13;0
WireConnection;0;9;3;0
ASEEND*/
//CHKSM=EA27745478145AFC61BD9F8A95BA1B720101B7C4