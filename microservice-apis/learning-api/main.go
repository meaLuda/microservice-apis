package main

import (
	"github.com/gin-gonic/gin"
	"microLearningApi/models"
)


func main() {
	r := gin.Default()
	err := models.ConnectDb()
	checkErr(err)
	// Test_db_conntection_getRadioStationCategory()
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

	v2 := r.Group("/api/radioAPI/v1")
	{
		v2.GET("radioCategorites", getRadioCategories)

	}

	// By default it serves on :8080 unless a
	// PORT environment variable was defined.
	r.Run()
}

