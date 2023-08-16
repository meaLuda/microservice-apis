package main

import (
	"github.com/gin-gonic/gin"
	"collegeAPI/models"
)


func main() {
	r := gin.Default()
	err := models.ConnectDb()
	checkErr(err)
	// Test_db_conntection_getRadioStationCategory()
	// //API v1
	v1 := r.Group("/api/college_app/v1")
	{
		v1.GET("all_depertments",getCourses)
		//   v1.POST("person", addPerson)
		//   v1.PUT("person/:id", updatePerson)
		//   v1.DELETE("person/:id", deletePerson)
		//   v1.OPTIONS("person", options)
	}

	
	// By default it serves on :8080 unless a
	// PORT environment variable was defined.
	r.Run()
}

