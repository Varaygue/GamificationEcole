using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LivesCount : MonoBehaviour
{
    public GameObject parentObject; // Assign the parent GameObject in the inspector
    public List<GameObject> childObjects = new List<GameObject>(); // Use List instead of array
    public Ship shipLives;

    void Start()
    {
        // Fill the list with children of the parentObject
        foreach (Transform child in parentObject.transform)
        {
            childObjects.Add(child.gameObject);
        }

        // Optional: Print the names of all children to verify
        foreach (GameObject child in childObjects)
        {
            Debug.Log(child.name);
        }
    }

    public void LifeUpdate()
    {
        // Check if the variableToDecrease is less than a certain value
        if (shipLives != null)
    {
        // Remove the first object from the list
        GameObject removedObject = childObjects[0];
        childObjects.RemoveAt(0);

        // Destroy the removed object
        Destroy(removedObject);
    }
    }
}
