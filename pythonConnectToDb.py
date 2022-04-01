import cx_Oracle
#cx_Oracle.init_oracle_client(lib_dir=r"your path to Oracle client")
database = "@itc3260.acgadmin.edu:1521/orcl"
username = input("Username: ")
password = input("Password: ")
connection_string = username + "/" + password + database
try:
    cx_Oracle.init_oracle_client(lib_dir=r"C:\Programs\oracleClient")
    #connection = cx_Oracle.connect('hr/oracle@itc3260.acgadmin.edu:1521/orcl')
    connection = cx_Oracle.connect(connection_string)
    #print("Login to ", loginInfo, " was successful")
except:
    print("Login failed.")
#define always your connection cursor
cursor = connection.cursor()

#How to select data from the database
results = cursor.execute("SELECT employee_id, last_name, first_name, salary FROM dara_emp")
for row in results:
    print(row[0], row[1], row[2], row[3])

#TODO: Run "pip install cx_Oracle"
