USE `mydb`;
DROP procedure IF EXISTS `sp_InsertCourse`;

USE `mydb`;
DROP procedure IF EXISTS `mydb`.`sp_InsertCourse`;


DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertCourse` (
	IN p_Specialization VARCHAR(100),
    IN  p_Title           VARCHAR(100),
    IN  p_Language            VARCHAR(50),
    IN  p_Description            TEXT,
    IN  p_Price           VARCHAR(20),
    IN  p_Level           VARCHAR(15),
    IN  p_Duration        VARCHAR(15),
    IN  p_Teacher_ID      INT
)

BEGIN
	DECLARE check_teacher INT DEFAULT 0 ;
    DECLARE check_course INT DEFAULT 0; 

	-- ASSIGN ID FOR COURSE 
    
    -- Check Does This course has been exist in DataBase
    SELECT COUNT(*) INTO check_course 
    FROM Course 
    WHERE Title = p_Title AND Teacher_ID = p_Teacher_ID; 
    
    IF (check_course > 0) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[INSERT ERROR] This course has been create by you' ;
	END IF; 
    
    
    
	--  Check Tittle :
    IF p_Title IS NULL OR TRIM(p_Title) = '' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[INSERT ERROR] Tittle of Course cannot be null or Empty';
	END IF; 
    
    -- Check Course_Language :
    IF p_Language IS NULL OR TRIM(p_Language) = '' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[INSERT ERROR] Language of Course cannot be null or Empty';
	END IF; 
    
    -- Check Course_Level :
    IF p_Level NOT IN ('Beginner', 'Intermediate', 'Advanced') THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[INSERT ERROR] Level of Course must be one in ("Beginner", "Intermediate", "Advanced")';
	END IF;
    
    -- Check Price :
    IF p_Price IS NULL OR TRIM(p_Price) = '' OR p_Price = 'Free' THEN 
		SET p_Price = 'FREE'; 
	END IF; 
    
    IF NOT (p_Price = 'FREE' OR p_Price LIKE '% USD') THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[INSERT ERROR] Price of Course must be like "Free" or "xx USD"' ;
	END IF; 
    
    -- Check Duration : 
    IF  (p_Duration IS NULL OR
		NOT (p_Duration LIKE '% Weeks' OR
			 p_Duration LIKE '% Months' OR
             p_Duration LIKE '% Week' OR
             p_Duration LIKE '% Month' OR
             p_Duration LIKE '% Day' OR
             p_Duration LIKE '% Days') ) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[INSERT ERROR] Duration of Course out of Format (xx Weeks, xx Days , xx Months)' ;
    END IF;
		
    -- Check ID of Teacher Who Make :
    
    SELECT COUNT(*) INTO check_teacher 
    FROM Teacher 
    WHERE p_Teacher_ID = ID ; 
    
	IF (check_teacher = 0) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[INSERT ERROR] ID of Teacher making Course Invalid '; 
    END IF; 
    
    -- Insert 
    INSERT INTO mydb.Course (
    
		Specialization,
		Title ,
		Course_Language ,
		Course_Description ,
		Price  ,
		Course_Level, 
		Duration, 
		Teacher_ID,
        Course_Status 
    )
    VALUES (
		p_Specialization  ,
		p_Title           ,
		p_Language        ,
		p_Description     ,
		p_Price           ,
		p_Level           ,
		p_Duration        ,
		p_Teacher_ID ,
        'Available'
    ); 
    
    SELECT LAST_INSERT_ID() AS NewCourseID; 
    
    
END$$


-- UPDATE COURSE 


DELIMITER $$

DROP PROCEDURE IF EXISTS sp_UpdateCourse $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UpdateCourse` (
    IN  p_ID            INT,
    IN  p_Title         VARCHAR(100),
    IN  p_Language      VARCHAR(50),
    IN  p_Description   TEXT,
    IN  p_Price         VARCHAR(20),
    IN  p_Level         VARCHAR(15),
    IN  p_Duration      VARCHAR(15),
    IN p_Specialization VARCHAR(100),
    IN  p_Teacher_ID    VARCHAR(20),
	IN  p_Status 	VARCHAR(20)

)
BEGIN 
    DECLARE v_oldTitle        VARCHAR(100); 
    DECLARE v_oldLanguage     VARCHAR(50); 
    DECLARE v_oldDescription  TEXT; 
    DECLARE v_oldPrice        VARCHAR(20); 
    DECLARE v_oldLevel        VARCHAR(15); 
    DECLARE v_oldDuration     VARCHAR(15); 
    DECLARE v_oldSpecialization VARCHAR(100); 
    DECLARE v_oldTeacherID    INT;
    DECLARE v_oldStatus 	ENUM('Available','Discarded');
    
    DECLARE v_newTitle        VARCHAR(100); 
    DECLARE v_newLanguage     VARCHAR(50); 
    DECLARE v_newDescription  TEXT; 
    DECLARE v_newPrice        VARCHAR(20); 
    DECLARE v_newLevel        VARCHAR(15); 
    DECLARE v_newDuration     VARCHAR(15); 
	DECLARE v_newSpecialization VARCHAR(100); 
    DECLARE v_newTeacherID    INT; 
    DECLARE v_newStatus ENUM('Available','Discarded');
    
    DECLARE v_course_count    INT DEFAULT 0;
    DECLARE v_teacher_count   INT DEFAULT 0; 
    
    SELECT COUNT(*) INTO v_course_count
    FROM Course 
    WHERE ID = p_ID; 
    
    IF (v_course_count = 0) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '[UPDATE ERROR] This course does not exist in database.';
    END IF; 
    
    
    SELECT 
        Title,
        Course_Language,
        Course_Description,
        Price,
        Course_Level,
        Duration,
        Specialization, 
        Teacher_ID,
        Course_Status
    INTO
        v_oldTitle,
        v_oldLanguage,
        v_oldDescription,
        v_oldPrice,
        v_oldLevel,
        v_oldDuration,
        v_oldSpecialization,
        v_oldTeacherID,
        v_oldStatus
    FROM Course
    WHERE ID = p_ID;
    

    
    -- 3. If param = keep. set oldvalue
    SET v_newTitle       = IF(p_Title        = '__KEEP__', v_oldTitle,      p_Title);
    SET v_newLanguage    = IF(p_Language     = '__KEEP__', v_oldLanguage,   p_Language);
    SET v_newDescription = IF(p_Description  = '__KEEP__', v_oldDescription,p_Description);
    SET v_newPrice       = IF(p_Price        = '__KEEP__', v_oldPrice,      p_Price);
    SET v_newLevel       = IF(p_Level        = '__KEEP__', v_oldLevel,      p_Level);
    SET v_newDuration    = IF(p_Duration     = '__KEEP__', v_oldDuration,   p_Duration);
    SET v_newTeacherID   = IF(p_Teacher_ID   = '__KEEP__', v_oldTeacherID,
                              CAST(p_Teacher_ID AS SIGNED));
	SET v_newSpecialization = IF(p_Specialization = '__KEEP__', v_oldSpecialization, p_Specialization);
	
	SET v_newStatus 	 = IF(p_Status		 = '__KEEP__', v_oldStatus, CAST(p_Status AS CHAR));

    IF v_newTitle IS NULL OR TRIM(v_newTitle) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '[UPDATE ERROR] Title of course cannot be null or empty';
    END IF;
    
    IF v_newLanguage IS NULL OR TRIM(v_newLanguage) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '[UPDATE ERROR] Language of course cannot be null or empty';
    END IF;

    IF v_newLevel NOT IN ('Beginner', 'Intermediate', 'Advanced') THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '[UPDATE ERROR] Level of course must be one of ("Beginner", "Intermediate", "Advanced")';
    END IF;

    IF v_newPrice IS NULL OR TRIM(v_newPrice) = '' OR UPPER(v_newPrice) = 'FREE' THEN 
        SET v_newPrice = 'FREE'; 
    END IF; 
    
    IF NOT (v_newPrice = 'FREE' OR v_newPrice LIKE '% USD') THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '[UPDATE ERROR] Price of course must be "FREE" or in format "xx USD"' ;
    END IF; 

    IF  (v_newDuration IS NULL OR
         NOT (v_newDuration LIKE '% Weeks' OR
              v_newDuration LIKE '% Months' OR
              v_newDuration LIKE '% Week' OR
              v_newDuration LIKE '% Month' OR
              v_newDuration LIKE '% Day' OR
              v_newDuration LIKE '% Days')) THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '[UPDATE ERROR] Duration of course is out of format (xx Weeks, xx Days, xx Months)' ;
    END IF;

	
    
    SELECT COUNT(*) INTO v_teacher_count 
    FROM Teacher 
    WHERE ID = v_newTeacherID;
    
    IF (v_teacher_count = 0) THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '[UPDATE ERROR] ID of teacher for this course is invalid.';
    END IF; 
    
    UPDATE Course
    SET 
		Specialization   = v_newSpecialization ,
        Title            = v_newTitle, 
        Course_Language  = v_newLanguage, 
        Course_Description = v_newDescription, 
        Price            = v_newPrice, 
        Course_Level     = v_newLevel, 
        Duration         = v_newDuration, 
        Teacher_ID       = v_newTeacherID,
        Course_Status     = v_newStatus
    WHERE ID = p_ID; 

    SELECT ROW_COUNT() AS AffectedRows;
END$$

DELIMITER ;


-- Delete Course : Soft and Hard 


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_SoftDeleteCourse $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SoftDeleteCourse` (
	IN p_CourseID INT, 
    IN p_RequestTeacherID INT 
)
BEGIN 
	DECLARE v_OwnerTeacherID INT;
	DECLARE v_Status TEXT;

    -- Check course exist 
    SELECT Teacher_ID INTO v_OwnerTeacherID 
    FROM Course 
    WHERE p_CourseID = ID;

    SELECT Course_Status INTO v_Status
    FROM Course 
    WHERE p_CourseID = ID;
    
    
    IF (v_OwnerTeacherID IS NULL) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[SOFT DELETE ERROR] Course does not exist' ; 
	END IF;
    --  Check owner of this course match 
    
    IF (p_RequestTeacherid <> v_OwnerTeacherID) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[SOFT DELETE ERROR] You are not allow to delete this course'; 
	END IF; 
    
    -- Check this course has been deleted ? 
    
    IF EXISTS (SELECT 1 FROM Course WHERE ID = p_CourseID AND v_Status = 'Discarded') THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[SOFT DELETE ERROR] Course has been deleted'; 
	END IF; 
    
    -- Soft deleted 
    
    UPDATE Course 
    SET 
		Course_Status = 'Discarded', 
        Delete_Date = NOW(), 
        Delete_By = p_RequestTeacherID
	WHERE ID = p_CourseID; 
END$$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_HardDeleteCourse $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_HardDeleteCourse` (
	IN p_CourseID INT, 
    IN p_RequestTeacherID INT 
)
BEGIN
	DECLARE v_OwnerTeacherID INT;
	DECLARE v_count_enroll INT DEFAULT 0;

	SELECT Teacher_ID INTO v_OwnerTeacherID 
    FROM Course 
    WHERE ID = p_CourseID;
    
    IF (v_OwnerTeacherID IS NULL) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[HARD DELETE ERROR] Course does not exist'; 
	END IF;
    
    IF (p_RequestTeacherID <> v_OwnerTeacherID) THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[HARD DELETE ERROR] You are not allowed to delete this course'; 
	END IF; 
    
    
    SELECT COUNT(*) INTO v_count_enroll 
    FROM Enrollment
    WHERE Course_ID = p_CourseID; 
    
    IF (v_count_enroll > 0 ) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '[HARD DELETE ERROR] Cannot hard-delete: Students have enrolled in this course.';
    END IF; 


	START TRANSACTION; 
		
        DELETE QO FROM Question_Option QO
        INNER JOIN Question Q ON QO.Question_ID = Q.Question_ID
        WHERE Q.Q_Course_ID = p_CourseID;
        
        DELETE FROM Question WHERE Q_Course_ID = p_CourseID; 
        DELETE FROM Quiz WHERE Course_ID = p_CourseID;
        DELETE FROM Video WHERE Course_ID = p_CourseID;
        DELETE FROM Reading WHERE Course_ID = p_CourseID;
        DELETE FROM Learning_Item WHERE Course_ID = p_CourseID;
        DELETE FROM Module WHERE Course_ID = p_CourseID;
        
        DELETE FROM Course WHERE ID = p_CourseID; 
		
	COMMIT;
    
END $$

DELIMITER ;


DELIMITER $$

DROP PROCEDURE IF EXISTS sp_ViewCourse $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ViewCourse` (
	    IN  p_ID            INT)
BEGIN 
	SELECT * FROM mydb.Course WHERE Course.ID = p_ID;
END $$

DELIMITER ;






-- call sp_InsertCourse ("DATABASE", "ENGLISH", "HHHH", "10 USD", "Beginner", "2 Weeks", 2310001); 
-- call sp_UpdateCourse (300011, '__KEEP__','__KEEP__', "50 USD", '__KEEP__', '__KEEP__', '__KEEP__', 2310001,'Available'  ); 
-- CALL sp_HardDeleteCourse(300011,2310001 ) ; 
-- SET SQL_SAFE_UPDATES = 0;
-- CALL sp_HardDeleteCourse(300000,2310001 ) ; 
-- SET SQL_SAFE_UPDATES = 1; 

