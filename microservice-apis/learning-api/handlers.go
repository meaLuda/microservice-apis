package main

import (
	_ "fmt"
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
	radioCat, err := models.GetAllRadioStationCategories()

	checkErr(err)

	if radioCat == nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No Records Found"})
		return
	} else {
		// return persons
		c.JSON(http.StatusOK, gin.H{"data": radioCat})
	}
}
