DELIMITER $$

DROP PROCEDURE IF EXISTS sp_SearchCourses $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SearchCourses` (
    IN p_Keyword      VARCHAR(100), 
    IN p_MinPrice        DECIMAL(10,2),  
	IN p_MaxPrice     DECIMAL(10,2),  
    IN p_Level        VARCHAR(15),
    IN p_Language     VARCHAR(50),  
    IN p_TeacherID    INT,          
    IN p_Specialization VARCHAR(100) 
)
BEGIN
	IF (p_MinPrice < 0 OR p_MaxPrice < 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[Search Error]: Money cannot negative number.';
    END IF;

    IF (p_MinPrice IS NOT NULL AND p_MaxPrice IS NOT NULL AND p_MinPrice > p_MaxPrice) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '[Search Error]: Min value can not greater than max value.';
    END IF;
    SELECT 
        C.ID,
        C.Title,
        C.Specialization,
        C.Price,
        C.Course_Level,
        C.Course_Language,
        C.Duration,
        CONCAT(U.First_Name, ' ', U.Last_Name) AS Teacher_Name,
        C.Course_Status, 
        C.Teacher_ID
    FROM 
        Course C
    INNER JOIN Teacher T ON C.Teacher_ID = T.ID
    INNER JOIN Users U ON T.ID = U.ID
    
    WHERE 
        C.Course_Status = 'Available' 
        
        AND (
        (p_MinPrice IS NULL AND p_MaxPrice IS NULL) 
        OR 
        (
            CAST(
                CASE 
                    WHEN C.Price = 'Free' THEN 0
                    ELSE SUBSTRING_INDEX(C.Price, ' ', 1) 
                END AS DECIMAL(10,2)
            ) BETWEEN COALESCE(p_MinPrice, 0) AND COALESCE(p_MaxPrice, 9999999)
        )
    )
        AND (
            p_Keyword IS NULL 
            OR C.Title LIKE CONCAT('%', p_Keyword, '%')
            OR C.Course_Description LIKE CONCAT('%', p_Keyword, '%')
            OR C.Specialization LIKE CONCAT('%', p_Keyword, '%')
        )
        
        AND (p_Level IS NULL OR C.Course_Level = p_Level)
        
        AND (p_Language IS NULL OR C.Course_Language = p_Language)
        
        AND (p_TeacherID IS NULL OR C.Teacher_ID = p_TeacherID)
        
        AND (p_Specialization IS NULL OR C.Specialization LIKE CONCAT('%', p_Specialization, '%'))
        
    ORDER BY 
        CASE 
            WHEN p_Keyword IS NOT NULL AND C.Title LIKE CONCAT(p_Keyword, '%') THEN 0 
            ELSE 1 
        END,
        C.Title ASC;
        
END $$

DELIMITER ;

