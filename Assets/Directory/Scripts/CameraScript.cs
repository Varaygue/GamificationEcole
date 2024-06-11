using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraScript : MonoBehaviour
{
    public Transform playerShip;
    public float offset;

    // Update is called once per frame
    void Update()
    {
        // Get the current camera position
        Vector3 cameraPosition = transform.position;
        
        // Update the x position to follow the player
        cameraPosition.x = playerShip.position.x - offset;
        
        // Set the camera's position to the updated position
        transform.position = cameraPosition;
    }
}
