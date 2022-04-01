import cx_Oracle
#cx_Oracle.init_oracle_client(lib_dir=r"your path to Oracle client")
database = "@itc3260.acgadmin.edu:1521/orcl"
username = input("Username: ")
password = input("Password: ")
connection_string = username + "/" + password + database
connected = 1
try:
    cx_Oracle.init_oracle_client(lib_dir=r"C:\Programs\oracleClient")
    #connection = cx_Oracle.connect('hr/oracle@itc3260.acgadmin.edu:1521/orcl')
    connection = cx_Oracle.connect(connection_string)
    #print("Login to ", loginInfo, " was successful")
except:
    print("Login failed.")
    connected = 0

def print_query(query_output):
    output = ""
    for row in (query_output):
        for idx in range(0, len(row)):
            if idx==0:
                output += str(row[idx])
            else:
                output += " " + str(row[idx])
        output += "\n"
    output = output[0:len(output)-1]
    print(output)

if connected:
    # Always define your connection cursor to be able to fetch data from the db
    cursor = connection.cursor()

    # How to select data from the database
    # Define and execute your select statement
    select_statement = "SELECT employee_id, last_name, first_name, salary FROM dara_emp"
    results = cursor.execute(select_statement)

    print_query(results)

#TODO: Run "pip install cx_Oracle"
