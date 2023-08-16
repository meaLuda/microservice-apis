package main

import (
	_ "fmt"
	"github.com/gin-gonic/gin"
	"log"
	"collegeAPI/models"
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
	courses, err := models.GetDepertments(10)

	checkErr(err)

	if courses == nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No Records Found"})
		return
	} else {
		// return persons
		c.JSON(http.StatusOK, gin.H{"data": courses})
	}

}
