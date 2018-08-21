using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace AdultLink
{
	public class SetColor : MonoBehaviour {

		// Use this for initialization
		public GameObject[] objects;
		public Color newColor;
		private Material[] mats;
		void Start () {
			mats = new Material[objects.Length];
			for (int i = 0; i < objects.Length; i++) {
				//Debug.Log(objects[i]);
				mats[i] = objects[i].GetComponent<Renderer>().material;
				//Debug.Log(mats[i]);
			}
		}
		
		// Update is called once per frame
		void FixedUpdate () {
			for (int i = 0; i < mats.Length; i++) {
				//Debug.Log(mats[i]);
				mats[i].SetColor("_Color", newColor);
			}
		}
	}
	
}
