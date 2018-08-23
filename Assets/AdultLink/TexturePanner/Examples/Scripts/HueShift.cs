using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace AdultLink
{
	public class HueShift : MonoBehaviour {

		// Use this for initialization

		private Material mat;
		public float speed = 0.1f;
		public Color color = Color.red;
		public float brightness = 1.2f;
		void Start () {

			mat = GetComponent<Renderer>().material;
		}
		
		// Update is called once per frame
		void FixedUpdate () {
				float hue;
				float sat;
				float value;
				Color.RGBToHSV(color, out hue, out sat, out value);
				mat.SetColor("_Color", color);
				hue += Time.fixedDeltaTime * speed;

				if (hue > 1.0f) {
					hue = 0f;
				}

				if (hue < 0f) {
					hue = 1.0f;
				}
				color = Color.HSVToRGB(hue,sat,brightness);
		}
	}
}
	
