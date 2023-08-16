package models

import (
	"database/sql"
	"log"
)

// global variable
var DB *sql.DB

func ConnectDb() error{
	db, err := sql.Open("sqlite3","models/db.sqlite3")

	// check when an error occurs
	if err != nil{
		log.Fatal(err)
		return err
	}

	// Set value of DB to this new db
	DB = db 
	log.Println("--------- Connected to the database ------------------")
	return nil
}