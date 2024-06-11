using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipMovement : MonoBehaviour
{
    public Rigidbody rb;
    public float moveSpeed=5;

void Update () {

    Vector3 movement = new Vector3 ();

    if (Input.GetKey (KeyCode.A))
        movement += Vector3.left;

    if (Input.GetKey (KeyCode.D))
        movement += Vector3.right;
    
    if (Input.GetKey (KeyCode.W))
        movement += Vector3.forward;

    if (Input.GetKey (KeyCode.S))
        movement += Vector3.back;

    rb.AddForce (movement * moveSpeed * Time.deltaTime);

}
}
