;; Function to write into CSV your: calculation id, taskname and time it took to complete a set of scripts

;; Example Usage:
;; 1) In this file/your own code if loaded as file: Define csv filename, calculation id and optionally change headers
;; 2) To time a task, initialize starting time with:
; (define start_time (time))
;; 2) Do your task
;; 3) After your own scripts, use the function to write a line into csv
; (csv_script_timer "Task" (time) start_time)


; Define summaryfile, calculation id and headers in file
(load-pyscheme-library)
(define summary_csv_filename "./info.csv")
(define calculation_ID "calculation_1")
(define summary_csv_headers (list "calculation_ID" "taskname" "hours" "minutes" "seconds"))


(define (csv_script_timer taskname dt_end dt_start)

    ; Parse hours, minutes and seconds from input times
    (define total_seconds (- dt_end dt_start))
    (define hours (floor (/ total_seconds 3600)))
    (define minutes (modulo (floor (/ total_seconds 60)) 60))
    (define seconds (floor (modulo total_seconds 60)))

    ; Check if file exists. If not, header needs to be written to it.
    (if (file-exists? summary_csv_filename) (define write_header #f) (define write_header #t))

    ; Define csv dataline that will be appended into csv
    (define csv_dataline (format #f "~a,~a,~a,~a,~a" calculation_ID taskname hours minutes seconds))

    ; Open file with append
    (%py-exec (format #f "f = open('~a', 'a')" summary_csv_filename))

    ; If file did not exist, write header and newline
    (if write_header 
        (begin
            (%py-exec (format #f "f.write('~a')" (string-join summary_csv_headers ",")))
            ; Add newline.Linux needs \\n and windows \n
            (if (unix?)
                (%py-exec (format #f "f.write('\\n')"))
                (%py-exec (format #f "f.write('\n')"))
            )
        )
    )
    
    ; Write dataline and newline
    (%py-exec (format #f "f.write('~a')" csv_dataline))
    (if (unix?)
        (%py-exec (format #f "f.write('\\n')"))
        (%py-exec (format #f "f.write('\n')"))
    )

    ; Close file
    (%py-exec "f.close()")
)




