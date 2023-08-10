package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"log"
	"microLearningApi/models"
	"net/http"
)

// re-usable function to check errors
func checkErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func test_db_conntection_getCourses() {
	// Test connection result
	courses, err_ := models.GetCourses(10)

	checkErr(err_)

	if courses == nil {
		fmt.Println("No records found")
		return
	} else {
		// return records
		fmt.Println(courses)
	}
}

func test_db_conntection_getLessons() {
	// Test connection result
	courses, err_ := models.GetLessons()

	checkErr(err_)

	if courses == nil {
		fmt.Println("No records found")
		return
	} else {
		// return records
		fmt.Println(courses)
	}
}

func test_db_conntection_getRadioStationCategory() {
	// Test connection result
	courses, err_ := models.GetAllRadioStationCategories()

	checkErr(err_)

	if courses == nil {
		fmt.Println("No records found")
		return
	} else {
		// return records
		fmt.Println(courses)
	}
}



func main() {
	r := gin.Default()
	err := models.ConnectDb()
	checkErr(err)
	// test_db_conntection_getLessons()
	// //API v1
	v1 := r.Group("/api/LearningAPI/v1")
	{
		v1.GET("courses", getCourses)
		v1.GET("lessons", getLessons)
		//   v1.POST("person", addPerson)
		//   v1.PUT("person/:id", updatePerson)
		//   v1.DELETE("person/:id", deletePerson)
		//   v1.OPTIONS("person", options)
	}

	v2 := r.Group("/api/radioAPI/v2")
	{
		v2.GET("radioCategorites", getRadioCategories)

	}

	// By default it serves on :8080 unless a
	// PORT environment variable was defined.
	r.Run()
}

// -------------------------- courses functions ---------------------------
func getCourses(c *gin.Context) {
	courses, err := models.GetCourses(10)

	checkErr(err)

	if courses == nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No Records Found"})
		return
	} else {
		// return persons
		c.JSON(http.StatusOK, gin.H{"data": courses})
	}

}

func getLessons(c *gin.Context) {
	lessons, err := models.GetLessons()

	checkErr(err)

	if lessons == nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No Records Found"})
		return
	} else {
		// return persons
		c.JSON(http.StatusOK, gin.H{"data": lessons})
	}

}

// ------------------------------ radio functions ---------------------------
func getRadioCategories(c *gin.Context) {

}
