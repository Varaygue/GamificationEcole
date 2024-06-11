using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using System.Collections;

public class Ship : MonoBehaviour
{
    public float movementSpeed = 5;
    public float laneChangeSpeed = 0.5f; // Speed of the lane change
    public GameObject[] navigableLanes;
    public int i;
    public int lives = 3;
    public int points;
    private Coroutine laneChangeCoroutine;
    public TMP_Text scoreText;
    public bool IsHit = false;
    public Animator shipAnimation;
    public LivesCount livesCount;
    public bool lostGame;
    public GameObject lostScreen;
    public int finalPoints;
    public TMP_Text finalScore;

    void Start()
    {
        i = 2; 
        if (i >= 0 && i < navigableLanes.Length)
        {
            UpdatePositionInstant();
        }
    }

    void Update()
    {
        // Always move right on the X axis
        transform.Translate(Vector3.right * Time.deltaTime * movementSpeed);

        // Handle lane change input
        if (Input.GetKeyDown(KeyCode.LeftArrow))
        {
            shipAnimation.SetTrigger("MoveLeft");
            ChangeLane(-1);
        }
        if (Input.GetKeyDown(KeyCode.RightArrow))
        {
            ChangeLane(1);
            shipAnimation.SetTrigger("MoveRight");
        }
        scoreText.text = points.ToString();
        if(lives==0)
        {
            PerduPartie();
        }
        finalPoints = points;
        finalScore.text = finalPoints.ToString();
    }

    public void PerduPartie()
    {
        movementSpeed=0;
        lostScreen.SetActive(true);
    }

    public void OnTriggerEnter(Collider other)
    {
    if (other.CompareTag("Points"))
        {
            points = points+10;
            Destroy(other.gameObject);
        }
    if(other.CompareTag("Iceberg")&&IsHit!=true)
        {
            StartCoroutine(DamageTaken());
        }
    }

    private IEnumerator DamageTaken()
    {
        lives = lives-1;
        shipAnimation.SetTrigger("Damage");
        IsHit = true;
        livesCount.LifeUpdate();
        yield return new WaitForSeconds(1.5f);
        IsHit = false;
        shipAnimation.ResetTrigger("Damage");
    }

    void ChangeLane(int direction)
    {
        int newLaneIndex = i + direction;
        if (newLaneIndex >= 0 && newLaneIndex < navigableLanes.Length)
        {
            i = newLaneIndex;
            if (laneChangeCoroutine != null)
            {
                StopCoroutine(laneChangeCoroutine);
            }
            laneChangeCoroutine = StartCoroutine(SmoothLaneChange());
        }
    }

    void UpdatePositionInstant()
    {
        Vector3 newPosition = transform.position;
        newPosition.z = navigableLanes[i].transform.position.z;
        transform.position = newPosition;
    }

    IEnumerator SmoothLaneChange()
    {
        Vector3 startPosition = transform.position;
        Vector3 targetPosition = new Vector3(startPosition.x, startPosition.y, navigableLanes[i].transform.position.z);
        float elapsedTime = 0;

        while (elapsedTime < laneChangeSpeed)
        {
            // Move smoothly to the new Z position
            float z = Mathf.Lerp(startPosition.z, targetPosition.z, elapsedTime / laneChangeSpeed);
            transform.position = new Vector3(transform.position.x, transform.position.y, z);

            // Add horizontal movement
            transform.Translate(Vector3.right * Time.deltaTime * movementSpeed);

            elapsedTime += Time.deltaTime;
            yield return null;
        }

        shipAnimation.ResetTrigger("MoveLeft");
        shipAnimation.ResetTrigger("MoveRight");
        transform.position = new Vector3(transform.position.x, transform.position.y, targetPosition.z);
        
    }
}
