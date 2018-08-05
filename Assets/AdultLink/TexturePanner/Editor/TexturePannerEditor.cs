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
	//SCROLLING
	private MaterialProperty _Scrolling = null;
	private MaterialProperty _ScrollingspeedX = null;
	private MaterialProperty _ScrollingspeedY = null;

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

	//FOLDOUT BOOLS

	protected static bool ShowGeneralSettings = true;
	protected static bool ShowScrollingSettings = true;
	protected static bool ShowEmissionSettings = true;
	protected static bool ShowScanlinesSettings = true;
	protected static bool ShowScanlinesXSettings = true;
	protected static bool ShowScanlinesYSettings = true;
	protected static bool ShowScanlinesZSettings = true;
	protected static bool ShowVerticalStretchSettings = true;
	protected static bool ShowVerticalDisplacementSettings = true;
	GUIStyle foldoutStyle = new GUIStyle(EditorStyles.foldout);

	public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
		_properties = properties;
		_materialEditor = materialEditor;
		DrawGUI();
	}

	void InitializeFoldoutStyle() {
 		foldoutStyle.fontStyle = FontStyle.Bold;
	}
	void DrawGUI() {
		InitializeFoldoutStyle();
		GetProperties();
		ShowGeneralSettings = EditorGUILayout.Foldout(ShowGeneralSettings, "General settings", foldoutStyle);
		if (ShowGeneralSettings){
			DrawMainSettings();
		}
		ShowScrollingSettings = EditorGUILayout.Foldout(ShowScrollingSettings, "Scrolling", foldoutStyle);
		if (ShowScrollingSettings){
			DrawScrollingSettings();
		}
		ShowEmissionSettings = EditorGUILayout.Foldout(ShowEmissionSettings, "Emission pulsation", foldoutStyle);
		if (ShowEmissionSettings){
			DrawEmissionSettings();
		}
		ShowScanlinesSettings = EditorGUILayout.Foldout(ShowScanlinesSettings, "Scanlines", foldoutStyle);
		if (ShowScanlinesSettings){
			DrawScanlinesSettings();
		}
		ShowVerticalStretchSettings = EditorGUILayout.Foldout(ShowVerticalStretchSettings, "Vertical stretch", foldoutStyle);
		if (ShowVerticalStretchSettings){
			DrawVerticalstretchSettings();
		}
		ShowVerticalDisplacementSettings = EditorGUILayout.Foldout(ShowVerticalDisplacementSettings, "Vertical displacement", foldoutStyle);
		if (ShowVerticalDisplacementSettings){
			DrawVerticaldisplacementSettings();
		}
    }

	void GetProperties() {

		//MAIN SETTINGS
		_Tex = FindProperty("_Tex", _properties);
		_Offset = FindProperty("_Offset", _properties);
		_Tiling = FindProperty("_Tiling", _properties);
		_Color = FindProperty("_Color", _properties);
		_Colormode = FindProperty("_Colormode", _properties);
		//SCROLLING
		_Scrolling = FindProperty("_Scrolling", _properties);
		_ScrollingspeedX = FindProperty("_ScrollingspeedX", _properties);
		_ScrollingspeedY = FindProperty("_ScrollingspeedY", _properties);
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
		//VERTICALMOVEMENT
		_Verticalmovement = FindProperty("_Verticalmovement", _properties);
		_Verticalmovementamplitude = FindProperty("_Verticalmovementamplitude", _properties);
		_Verticalmovementfreq = FindProperty("_Verticalmovementfreq", _properties);
		_Verticalmovementoffset = FindProperty("_Verticalmovementoffset", _properties);
	}

	void DrawMainSettings() {
		//MAIN SETTINGS
		GUILayout.Space(-3);
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Tex, "Texture");
		_materialEditor.ShaderProperty(_Tiling, _Tiling.displayName);
		_materialEditor.ShaderProperty(_Offset, _Offset.displayName);
		_materialEditor.ShaderProperty(_Color, _Color.displayName);
		_materialEditor.ShaderProperty(_Colormode, _Colormode.displayName);
		EditorGUI.indentLevel--;
	}

	void DrawScanlinesSettings() {
		//SCANLINES
		GUILayout.Space(-3);
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		//X
		ShowScanlinesXSettings = EditorGUILayout.Foldout(ShowScanlinesXSettings, "Scanlines X", foldoutStyle);
		if (ShowScanlinesXSettings){
			EditorGUI.indentLevel++;
			_materialEditor.ShaderProperty(_ScanlinesX, "Enable");
			_materialEditor.ShaderProperty(_ScanlinesscaleX, "Scale");
			_materialEditor.ShaderProperty(_ScanlinesspeedX, "Speed");
			_materialEditor.ShaderProperty(_SharpX, "Sharp");
			EditorGUI.indentLevel--;
		}
		//Y
		ShowScanlinesYSettings = EditorGUILayout.Foldout(ShowScanlinesYSettings, "Scanlines Y", foldoutStyle);
		if (ShowScanlinesYSettings){
			EditorGUI.indentLevel++;
			_materialEditor.ShaderProperty(_ScanlinesY, "Enable");
			_materialEditor.ShaderProperty(_ScanlinesscaleY, "Scale");
			_materialEditor.ShaderProperty(_ScanlinesspeedY, "Speed");
			_materialEditor.ShaderProperty(_SharpY, "Sharp");
			EditorGUI.indentLevel--;
			}
		//Z
		ShowScanlinesZSettings = EditorGUILayout.Foldout(ShowScanlinesZSettings, "Scanlines Z", foldoutStyle);
		if (ShowScanlinesZSettings){
			EditorGUI.indentLevel++;
			_materialEditor.ShaderProperty(_ScanlinesZ, "Enable");
			_materialEditor.ShaderProperty(_ScanlinesscaleZ, "Scale");
			_materialEditor.ShaderProperty(_ScanlinesspeedZ, "Speed");
			_materialEditor.ShaderProperty(_SharpZ, "Sharp");
			EditorGUI.indentLevel--;
			}
		EditorGUI.indentLevel--;
	}

	void DrawEmissionSettings() {
		//GLOBAL EMISSION
		GUILayout.Space(-3);
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Globalemissionflicker, "Enable");
		_materialEditor.ShaderProperty(_Globalemissionflickeramplitude, "Amplitude");
		_materialEditor.ShaderProperty(_Globalemissionflickerfreq, "Frequency");
		_materialEditor.ShaderProperty(_Globalemissionflickeroffset, "Offset");
		EditorGUI.indentLevel--;
	}

	void DrawScrollingSettings() {
		
		//SCROLLING
		GUILayout.Space(-3);
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Scrolling, "Enable");
		_materialEditor.ShaderProperty(_ScrollingspeedX, _ScrollingspeedX.displayName);
		_materialEditor.ShaderProperty(_ScrollingspeedY, _ScrollingspeedY.displayName);
		EditorGUI.indentLevel--;
		}
	

	void DrawVerticalstretchSettings() {
		//VERTICAL STRETCH
		GUILayout.Space(-3);
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Verticalstretch, "Enable");
		_materialEditor.ShaderProperty(_Verticalstretchamplitude, "Amplitude");
		_materialEditor.ShaderProperty(_Verticalstretchfreq, "Frequency");
		_materialEditor.ShaderProperty(_Verticalstretchpivotpoint, "Point of origin offset");
		_materialEditor.ShaderProperty(_Verticalstretchoffset, "Offset");
		EditorGUI.indentLevel--;
	}

	void DrawVerticaldisplacementSettings() {
		//VERTICAL MOVEMENT
		GUILayout.Space(-3);
        EditorGUI.indentLevel++;
		_materialEditor.SetDefaultGUIWidths();
		_materialEditor.ShaderProperty(_Verticalmovement, "Enable");
		_materialEditor.ShaderProperty(_Verticalmovementamplitude, "Amplitude");
		_materialEditor.ShaderProperty(_Verticalmovementfreq, "Frequency");
		_materialEditor.ShaderProperty(_Verticalmovementoffset, "Point of origin offset");
		EditorGUI.indentLevel--;
	}
    

	
}