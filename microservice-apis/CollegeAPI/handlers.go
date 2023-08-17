package main

import (
	_ "fmt"
	"github.com/gin-gonic/gin"
	"log"
	"collegeAPI/models"
	"net/http"
	"strconv"
)


// re-usable function to check errors
func checkErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}


// -------------------------- courses functions ---------------------------
func get_DiplomaModule(c *gin.Context) {
	id,_ := strconv.Atoi(c.Param("id")) // get id from param and convert to int
	courses, err := models.GetDiplomaModule(id)

	checkErr(err)

	if courses == nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No Records Found"})
		return
	} else {
		// return persons
		c.JSON(http.StatusOK, gin.H{"data": courses})
	}

}


func get_DiplomaSubModule(c *gin.Context) {
	diploma_id,_ := strconv.Atoi(c.Param("diploma_id")) // get id from param and convert to int
	module_id,_ := strconv.Atoi(c.Param("module_id")) 
	courses, err := models.GetDiplomaSubModule(diploma_id,module_id)

	checkErr(err)

	if courses == nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "No Records Found"})
		return
	} else {
		// return persons
		c.JSON(http.StatusOK, gin.H{"data": courses})
	}

}