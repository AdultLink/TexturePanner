using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
namespace AdultLink {
	public class CameraController : MonoBehaviour {
		
		public float movementSpeed = 1f;
		public float rotationSpeed = 10f;
		public float smoothTime = 0.3f;
		public Text nameText;
		public Text indexText;
		public Text descriptionText;
		public GameObject lockedIcon;
		public GameObject unlockedIcon;
		public CameraPositions[] cameraPositions;
		private bool lockCursor = true;
		private int positionIndex = 0;
		private Vector3 velocity = Vector3.zero;
		private Vector3 targetPos;
		private Vector3 targetRot;
		private bool freeView = false;
		private Camera cam;
		// Use this for initialization
		void Start () {
			cam = Camera.main;
			Cursor.visible = false;
			Cursor.lockState = CursorLockMode.Locked;
			setPosition();
			transform.position = targetPos;
			transform.rotation = Quaternion.Euler(targetRot);
		}
		
		// Update is called once per frame
		void Update () {

			//CAMERA STUFF
			if (Input.GetKeyDown(KeyCode.Tab)) {
				freeView = !freeView;
				toggleLockedIcon();
				if (!freeView) {
					setPosition();
					setCursorVisibility(false);
				}
			}

			//FREE VIEW
			if (freeView){
				if (lockCursor){
					movementSpeed = Mathf.Max(movementSpeed += Input.GetAxis("Mouse ScrollWheel"), 0.0f);
					transform.position += (transform.right * Input.GetAxis("Horizontal") + transform.forward * Input.GetAxis("Vertical")) * movementSpeed;
					transform.eulerAngles += new Vector3(-Input.GetAxis("Mouse Y"), Input.GetAxis("Mouse X"), 0f);
					detectElement();
				}
			}
			//"GALLERY" MODE
			else {
				if (Input.GetKeyDown(KeyCode.LeftArrow)) {
					positionIndex -= 1;
					if (positionIndex < 0){
						positionIndex = cameraPositions.Length-1;
					}
					setPosition();
				}

				if (Input.GetKeyDown(KeyCode.RightArrow)) {
					positionIndex += 1;
					if (positionIndex >= cameraPositions.Length){
						positionIndex = 0;
					}
					setPosition();
				}

				//SMOOTH MOVEMENT TO THE DESIRED POSITION
				transform.position = Vector3.SmoothDamp(transform.position, targetPos, ref velocity, smoothTime);
				transform.rotation = Quaternion.RotateTowards(transform.rotation, Quaternion.Euler(targetRot), Time.deltaTime* rotationSpeed);

			}

			
			if (Input.GetKey(KeyCode.Escape)) {
				setCursorVisibility(true);
			}
			if (Input.GetKey(KeyCode.Mouse0)) {
				setCursorVisibility(false);
			}


		}

		private void setPosition() {
			targetPos = cameraPositions[positionIndex].pos;
			targetRot = cameraPositions[positionIndex].rot;
			setInfo();
		}

		private void setCursorVisibility(bool visible) {
			lockCursor = !visible;
			Cursor.visible = visible;
			Cursor.lockState = visible ? CursorLockMode.None : CursorLockMode.Locked;
		}

		private void detectElement() {
			RaycastHit hit;
			Ray ray = cam.ScreenPointToRay(Input.mousePosition);
			if (Physics.Raycast(ray, out hit)) {
				if (hit.transform.GetComponent<Index>() != null) {
					positionIndex = hit.transform.GetComponent<Index>().index;
					setInfo();
				}
			}
		}

		private void setInfo() {
			nameText.text = cameraPositions[positionIndex].name.ToString();
			indexText.text = (positionIndex+1).ToString() + "/" + cameraPositions.Length.ToString();
			descriptionText.text = cameraPositions[positionIndex].description.ToString();
		}

		private void toggleLockedIcon() {
			lockedIcon.SetActive(!lockedIcon.activeInHierarchy);
			unlockedIcon.SetActive(!unlockedIcon.activeInHierarchy);
		}
	}
}

