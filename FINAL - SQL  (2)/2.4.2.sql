DROP PROCEDURE IF EXISTS Calc_Course_Revenue;
DELIMITER $$

CREATE PROCEDURE Calc_Course_Revenue(
    IN  p_course_id      INT,
    OUT p_total_revenue  DECIMAL(18,2)
)
BEGIN
    DECLARE v_amount_str VARCHAR(20);
    DECLARE v_status     VARCHAR(10);
    DECLARE v_amount_num DECIMAL(18,2) DEFAULT 0;
    DECLARE done         INT DEFAULT 0;

    DECLARE cur_pay CURSOR FOR
        SELECT P.Ammount, P.Payment_Status
        FROM Payment P
        JOIN Enrollment E ON P.Enroll_ID = E.Enroll_ID
        WHERE E.Course_ID = p_course_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET p_total_revenue = 0;

    -- Kiểm tra tham số đầu vào
    IF p_course_id IS NULL OR p_course_id <= 0 THEN
        SET p_total_revenue = p_total_revenue;   -- NO-OP, tránh block rỗng

    ELSEIF NOT EXISTS (SELECT 1 FROM Course WHERE ID = p_course_id) THEN
        SET p_total_revenue = p_total_revenue;   -- NO-OP

    ELSE
        OPEN cur_pay;

        read_loop: LOOP
            FETCH cur_pay INTO v_amount_str, v_status;
            IF done = 1 THEN
                LEAVE read_loop;
            END IF;

            IF v_status = 'Paid' THEN
                IF v_amount_str IS NOT NULL AND v_amount_str <> 'Free' THEN
                    SET v_amount_num = CAST(v_amount_str AS DECIMAL(18,2));
                    SET p_total_revenue = p_total_revenue + v_amount_num;
                END IF;
            END IF;
        END LOOP;

        CLOSE cur_pay;
    END IF;
END $$

DELIMITER ;
