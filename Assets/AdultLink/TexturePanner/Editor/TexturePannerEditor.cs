using UnityEngine;
using UnityEditor;
 
public class TexturePannerEditor : ShaderGUI
{
	MaterialEditor _materialEditor;
	MaterialProperty[] _properties;

	//MAIN SETTINGS
	private MaterialProperty _Tex = null;
	private MaterialProperty _Offset = null;
	private MaterialProperty _Tiling = null;
	private MaterialProperty _Color = null;
	private MaterialProperty _Colormode = null;
	//SCROLLING/ROTATING
	private MaterialProperty _Scrollrotate = null;
	private MaterialProperty _ScrollingspeedX = null;
	private MaterialProperty _ScrollingspeedY = null;
	private MaterialProperty _RotationSpeed = null;

	//SCANLINES
	private MaterialProperty _ScanlinesX = null;
	private MaterialProperty _ScanlinesY = null;
	private MaterialProperty _ScanlinesZ = null;
	private MaterialProperty _ScanlinesscaleX = null;
	private MaterialProperty _ScanlinesscaleY = null;
	private MaterialProperty _ScanlinesscaleZ = null;
	private MaterialProperty _ScanlinesspeedX = null;
	private MaterialProperty _ScanlinesspeedY = null;
	private MaterialProperty _ScanlinesspeedZ = null;
	private MaterialProperty _SharpX = null;
	private MaterialProperty _SharpY = null;
	private MaterialProperty _SharpZ = null;

	//EMISSION
	private MaterialProperty _Globalemissionflicker = null;
	private MaterialProperty _Globalemissionflickeramplitude = null;
	private MaterialProperty _Globalemissionflickerfreq = null;
	private MaterialProperty _Globalemissionflickeroffset = null;

	//VERTICAL STRETCH
	private MaterialProperty _Verticalstretch = null;
	private MaterialProperty _Verticalstretchamplitude = null;
	private MaterialProperty _Verticalstretchfreq = null;
	private MaterialProperty _Verticalstretchpivotpoint = null;
	private MaterialProperty _Verticalstretchoffset = null;

	//VERTICAL MOVEMENT
	private MaterialProperty _Verticalmovement = null;
	private MaterialProperty _Verticalmovementamplitude = null;
	private MaterialProperty _Verticalmovementfreq = null;
	private MaterialProperty _Verticalmovementoffset = null;

	//HORIZONTAL STRETCH
	private MaterialProperty _Horizontalstretch = null;
	private MaterialProperty _Horizontalstretchamplitude = null;
	private MaterialProperty _Horizontalstretchfreq = null;
	private MaterialProperty _Horizontalstretchpivotpoint = null;
	private MaterialProperty _Horizontalstretchoffset = null;

	//HORIZONTAL MOVEMENT
	private MaterialProperty _Horizontalmovement = null;
	private MaterialProperty _Horizontalmovementamplitude = null;
	private MaterialProperty _Horizontalmovementfreq = null;
	private MaterialProperty _Horizontalmovementoffset = null;

	//TEXTURE MASKING
	private MaterialProperty _MaskingTex = null;
	private MaterialProperty _MaskTextureRotationSpeed = null;

	//FOLDOUT BOOLS

	protected static bool ShowGeneralSettings = true;
	protected static bool ShowScrollingSettings = true;
	protected static bool ShowEmissionSettings = true;
	protected static bool ShowScanlinesSettings = true;
	protected static bool ShowScanlinesXSettings = true;
	protected static bool ShowScanlinesYSettings = true;
	protected static bool ShowScanlinesZSettings = true;
	protected static bool ShowStretchSettings = true;
	protected static bool ShowVerticalStretchSettings = true;
	protected static bool ShowHorizontalStretchSettings = true;
	protected static bool ShowDisplacementSettings = true;
	protected static bool ShowVerticalDisplacementSettings = true;
	protected static bool ShowHorizontalDisplacementSettings = true;
	protected static bool ShowTextureMaskingSettings = true;
	

	public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
		_properties = properties;
		_materialEditor = materialEditor;
		EditorGUI.BeginChangeCheck();
		DrawGUI();
	}

	//void InitializeFoldoutStyle() {
 		//foldoutStyle.fontStyle = FontStyle.Bold;
	//}
	void DrawGUI() {
		//InitializeFoldoutStyle();
		GetProperties();
		DrawBanner();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		EditorGUI.indentLevel++;
		ShowGeneralSettings = EditorGUILayout.Foldout(ShowGeneralSettings, "General settings");
		if (ShowGeneralSettings){
			DrawMainSettings();
		}
		EditorGUI.indentLevel--;
		EditorGUILayout.EndVertical();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		EditorGUI.indentLevel++;
		ShowScrollingSettings = EditorGUILayout.Foldout(ShowScrollingSettings, "Scrolling/Rotation");
		if (ShowScrollingSettings){
			DrawScrollingSettings();
		}
		EditorGUI.indentLevel--;
		EditorGUILayout.EndVertical();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		EditorGUI.indentLevel++;
		ShowEmissionSettings = EditorGUILayout.Foldout(ShowEmissionSettings, "Emission pulsation");
		if (ShowEmissionSettings){
			DrawEmissionSettings();
		}
		EditorGUI.indentLevel--;
		EditorGUILayout.EndVertical();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		EditorGUI.indentLevel++;
		ShowScanlinesSettings = EditorGUILayout.Foldout(ShowScanlinesSettings, "Scanlines");
		if (ShowScanlinesSettings){
			DrawScanlinesSettings();
		}
		EditorGUI.indentLevel--;
		EditorGUILayout.EndVertical();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		EditorGUI.indentLevel++;
		ShowStretchSettings = EditorGUILayout.Foldout(ShowStretchSettings, "Stretching");
		if (ShowStretchSettings){
			DrawStretchSettings();
		}
		EditorGUI.indentLevel--;
		EditorGUILayout.EndVertical();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		EditorGUI.indentLevel++;
		ShowDisplacementSettings = EditorGUILayout.Foldout(ShowDisplacementSettings, "Displacement");
		if (ShowDisplacementSettings){
			DrawDisplacementSettings();
		}
		EditorGUI.indentLevel--;
		EditorGUILayout.EndVertical();

		EditorGUILayout.BeginVertical(EditorStyles.helpBox);
		EditorGUI.indentLevel++;
		ShowTextureMaskingSettings = EditorGUILayout.Foldout(ShowTextureMaskingSettings, "Masking");
		if (ShowTextureMaskingSettings){
			DrawTextureMaskingSettings();
		}
		EditorGUI.indentLevel--;
		EditorGUILayout.EndVertical();
    }

	void GetProperties() {

		//MAIN SETTINGS
		_Tex = FindProperty("_Tex", _properties);
		_Offset = FindProperty("_Offset", _properties);
		_Tiling = FindProperty("_Tiling", _properties);
		_Color = FindProperty("_Color", _properties);
		_Colormode = FindProperty("_Colormode", _properties);

		//SCROLLING/ROTATING
		_Scrollrotate = FindProperty("_Scrollrotate", _properties);
		_ScrollingspeedX = FindProperty("_ScrollingspeedX", _properties);
		_ScrollingspeedY = FindProperty("_ScrollingspeedY", _properties);
		_RotationSpeed = FindProperty("_RotationSpeed", _properties);

		//SCANLINES
		_ScanlinesX = FindProperty("_ScanlinesX", _properties);
		_ScanlinesscaleX = FindProperty("_ScanlinesscaleX", _properties);
		_ScanlinesspeedX = FindProperty("_ScanlinesspeedX", _properties);
		_SharpX = FindProperty("_SharpX", _properties);

		_ScanlinesY = FindProperty("_ScanlinesY", _properties);
		_ScanlinesscaleY = FindProperty("_ScanlinesscaleY", _properties);
		_ScanlinesspeedY = FindProperty("_ScanlinesspeedY", _properties);
		_SharpY = FindProperty("_SharpY", _properties);

		_ScanlinesZ = FindProperty("_ScanlinesZ", _properties);
		_ScanlinesscaleZ = FindProperty("_ScanlinesscaleZ", _properties);
		_ScanlinesspeedZ = FindProperty("_ScanlinesspeedZ", _properties);
		_SharpZ = FindProperty("_SharpZ", _properties);

		//EMISSION
		_Globalemissionflicker = FindProperty("_Globalemissionflicker", _properties);
		_Globalemissionflickeramplitude = FindProperty("_Globalemissionflickeramplitude", _properties);
		_Globalemissionflickerfreq = FindProperty("_Globalemissionflickerfreq", _properties);
		_Globalemissionflickeroffset = FindProperty("_Globalemissionflickeroffset", _properties);

		//VERTICAL STRETCH
		_Verticalstretch = FindProperty("_Verticalstretch", _properties);
		_Verticalstretchamplitude = FindProperty("_Verticalstretchamplitude", _properties);
		_Verticalstretchfreq = FindProperty("_Verticalstretchfreq", _properties);
		_Verticalstretchoffset = FindProperty("_Verticalstretchoffset", _properties);
		_Verticalstretchpivotpoint = FindProperty("_Verticalstretchpivotpoint", _properties);

		//VERTICAL MOVEMENT
		_Verticalmovement = FindProperty("_Verticalmovement", _properties);
		_Verticalmovementamplitude = FindProperty("_Verticalmovementamplitude", _properties);
		_Verticalmovementfreq = FindProperty("_Verticalmovementfreq", _properties);
		_Verticalmovementoffset = FindProperty("_Verticalmovementoffset", _properties);

		//HORIZONTAL STRETCH
		_Horizontalstretch = FindProperty("_Horizontalstretch", _properties);
		_Horizontalstretchamplitude = FindProperty("_Horizontalstretchamplitude", _properties);
		_Horizontalstretchfreq = FindProperty("_Horizontalstretchfreq", _properties);
		_Horizontalstretchoffset = FindProperty("_Horizontalstretchoffset", _properties);
		_Horizontalstretchpivotpoint = FindProperty("_Horizontalstretchpivotpoint", _properties);

		//HORIZONTAL MOVEMENT
		_Horizontalmovement = FindProperty("_Horizontalmovement", _properties);
		_Horizontalmovementamplitude = FindProperty("_Horizontalmovementamplitude", _properties);
		_Horizontalmovementfreq = FindProperty("_Horizontalmovementfreq", _properties);
		_Horizontalmovementoffset = FindProperty("_Horizontalmovementoffset", _properties);

		//MASKING
		_MaskingTex = FindProperty("_Masktexture", _properties);
		_MaskTextureRotationSpeed = FindProperty("_Masktexturerotationspeed", _properties);
	}

	static Texture2D bannerTexture = null;
    static GUIStyle title = null;
    static GUIStyle linkStyle = null;
    static string repoURL = "https://github.com/adultlink/texturepanner";

	void DrawBanner()
    {
        if (bannerTexture == null)
            bannerTexture = Resources.Load<Texture2D>("TexturePannerBanner");

        if (title == null)
        {
            title = new GUIStyle();
            title.fontSize = 20;
            title.alignment = TextAnchor.MiddleCenter;
            title.normal.textColor = new Color(1f, 1f, 1f);
        }
		

        if (linkStyle == null) linkStyle = new GUIStyle();

        if (bannerTexture != null)
        {
            GUILayout.Space(4);
            var rect = GUILayoutUtility.GetRect(0, int.MaxValue, 60, 60);
            EditorGUI.DrawPreviewTexture(rect, bannerTexture, null, ScaleMode.ScaleAndCrop);
            //
            EditorGUI.LabelField(rect, "Texture Panner", title);

            if (GUI.Button(rect, "", linkStyle)) {
                Application.OpenURL(repoURL);
            }
            GUILayout.Space(4);
        }
    }

	void DrawMainSettings() {
		//MAIN SETTINGS
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Tex, "Texture");
		_materialEditor.ShaderProperty(_Tiling, _Tiling.displayName);
		_materialEditor.ShaderProperty(_Offset, _Offset.displayName);
		_materialEditor.ShaderProperty(_Color, _Color.displayName);
		_materialEditor.ShaderProperty(_Colormode, _Colormode.displayName);
	}

	void DrawScanlinesSettings() {
		//SCANLINES
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		
		ShowScanlinesXSettings = EditorGUILayout.Foldout(ShowScanlinesXSettings, "Scanlines X");
		if (ShowScanlinesXSettings){
			_materialEditor.ShaderProperty(_ScanlinesX, "Enable");
			_materialEditor.ShaderProperty(_ScanlinesscaleX, "Scale");
			_materialEditor.ShaderProperty(_ScanlinesspeedX, "Speed");
			_materialEditor.ShaderProperty(_SharpX, "Sharp");
		}
		//Y
		ShowScanlinesYSettings = EditorGUILayout.Foldout(ShowScanlinesYSettings, "Scanlines Y");
		if (ShowScanlinesYSettings){
			_materialEditor.ShaderProperty(_ScanlinesY, "Enable");
			_materialEditor.ShaderProperty(_ScanlinesscaleY, "Scale");
			_materialEditor.ShaderProperty(_ScanlinesspeedY, "Speed");
			_materialEditor.ShaderProperty(_SharpY, "Sharp");
			}
		//Z
		ShowScanlinesZSettings = EditorGUILayout.Foldout(ShowScanlinesZSettings, "Scanlines Z");
		if (ShowScanlinesZSettings){
			_materialEditor.ShaderProperty(_ScanlinesZ, "Enable");
			_materialEditor.ShaderProperty(_ScanlinesscaleZ, "Scale");
			_materialEditor.ShaderProperty(_ScanlinesspeedZ, "Speed");
			_materialEditor.ShaderProperty(_SharpZ, "Sharp");
			}
		EditorGUI.indentLevel--;
	}

	void DrawEmissionSettings() {
		//GLOBAL EMISSION
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Globalemissionflicker, "Enable");
		_materialEditor.ShaderProperty(_Globalemissionflickeramplitude, "Amplitude");
		_materialEditor.ShaderProperty(_Globalemissionflickerfreq, "Frequency");
		_materialEditor.ShaderProperty(_Globalemissionflickeroffset, "Offset");
	}

	void DrawScrollingSettings() {
		
		//SCROLLING
		
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Scrollrotate, "Scroll/Rotate/None");
		_materialEditor.ShaderProperty(_ScrollingspeedX, _ScrollingspeedX.displayName);
		_materialEditor.ShaderProperty(_ScrollingspeedY, _ScrollingspeedY.displayName);
		_materialEditor.ShaderProperty(_RotationSpeed, _RotationSpeed.displayName);
		}
	

	void DrawStretchSettings() {
		//VERTICAL STRETCH
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		ShowVerticalStretchSettings = EditorGUILayout.Foldout(ShowVerticalStretchSettings, "Vertical stretching");
		if (ShowVerticalStretchSettings){
			_materialEditor.ShaderProperty(_Verticalstretch, "Enable");
			_materialEditor.ShaderProperty(_Verticalstretchamplitude, "Amplitude");
			_materialEditor.ShaderProperty(_Verticalstretchoffset, "Amplitude offset");
			_materialEditor.ShaderProperty(_Verticalstretchfreq, "Frequency");
			_materialEditor.ShaderProperty(_Verticalstretchpivotpoint, "Origin offset");
		}
		ShowHorizontalStretchSettings = EditorGUILayout.Foldout(ShowHorizontalStretchSettings, "Horizontal stretching");
		if (ShowHorizontalStretchSettings){
			_materialEditor.ShaderProperty(_Horizontalstretch, "Enable");
			_materialEditor.ShaderProperty(_Horizontalstretchamplitude, "Amplitude");
			_materialEditor.ShaderProperty(_Horizontalstretchoffset, "Amplitude offset");
			_materialEditor.ShaderProperty(_Horizontalstretchfreq, "Frequency");
			_materialEditor.ShaderProperty(_Horizontalstretchpivotpoint, "Origin offset");
		}
		EditorGUI.indentLevel--;
	}

	void DrawDisplacementSettings() {
		//VERTICAL MOVEMENT
        EditorGUI.indentLevel++;
		ShowVerticalDisplacementSettings = EditorGUILayout.Foldout(ShowVerticalDisplacementSettings, "Vertical displacement");
		if (ShowVerticalDisplacementSettings){
			_materialEditor.SetDefaultGUIWidths();
			_materialEditor.ShaderProperty(_Verticalmovement, "Enable");
			_materialEditor.ShaderProperty(_Verticalmovementamplitude, "Amplitude");
			_materialEditor.ShaderProperty(_Verticalmovementfreq, "Frequency");
			_materialEditor.ShaderProperty(_Verticalmovementoffset, "Origin offset");
		}
		ShowHorizontalDisplacementSettings = EditorGUILayout.Foldout(ShowHorizontalDisplacementSettings, "Horizontal displacement");
		if (ShowHorizontalDisplacementSettings){
			_materialEditor.SetDefaultGUIWidths();
			_materialEditor.ShaderProperty(_Horizontalmovement, "Enable");
			_materialEditor.ShaderProperty(_Horizontalmovementamplitude, "Amplitude");
			_materialEditor.ShaderProperty(_Horizontalmovementfreq, "Frequency");
			_materialEditor.ShaderProperty(_Horizontalmovementoffset, "Origin offset");
		}
		EditorGUI.indentLevel--;
	}

	void DrawTextureMaskingSettings() {
		//TEXTURE MASKING
        
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_MaskingTex, "Masking texture");
		_materialEditor.ShaderProperty(_MaskTextureRotationSpeed, "Rotation speed");
	}
	
}