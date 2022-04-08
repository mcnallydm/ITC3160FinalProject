from math import trunc
import cx_Oracle
#cx_Oracle.init_oracle_client(lib_dir=r"your path to Oracle client")
database = "@itc3260.acgadmin.edu:1521/orcl"
print("\nEnter 'mcnally' for both Username and Password.")
username = input("Username: ")
password = input("Password: ")
connection_string = username + "/" + password + database
connected = 1
try:
    cx_Oracle.init_oracle_client(lib_dir=r"C:\Programs\oracleClient")
    connection = cx_Oracle.connect(connection_string)
except:
    print("Login failed.")
    connected = 0

def tabs(data):
    # data is an array (of headers)
    tabs_needed = 0
    no_tabs=[1] * len(data)
    for attribute_idx in range(0, len(data)):
        tabs_needed = trunc(len(data[attribute_idx])/8)+1
        # 8 spaces make up a tab, but if the string is exactly 8 characters long, for clarity, a tab needs to be added
        if tabs_needed>no_tabs[attribute_idx]:
            no_tabs[attribute_idx] = tabs_needed
    # Returns the number of tabs needed between the columns
    return no_tabs

def print_query(headings, query_output):    # Prints a nicely formatted query with the given headings and data
    print("Printing Query...\n")
    q = []
    output = ""
    num_tabs = tabs(headings)

    qtemp = [] 
    t = 0
    for row in query_output:
        # Casts the query data to a string and appends it to a matrix for later display
        # Additionally calculates the number of tabs necessary to ensure proper spacing
        for idx in range(0, len(row)):
            dpt = str(row[idx]) # Casts the raw data to a string
            qtemp.append(dpt)
            t = trunc(len(dpt)/8)+1
            if t>num_tabs[idx]:
                num_tabs[idx] = t
        q.append(qtemp) # Appends entire row to matrix
        qtemp = []

    for i in range(0, len(headings)):
        if i==0:
            output += headings[i].upper()
        else:
            output += "\t"*(num_tabs[i-1] - (trunc(len(headings[i-1])/8))) + headings[i].upper()    # The math makes sure the columns are properly spaced
    output += "\n"

    for row in q:
        for idx in range(0, len(row)):
            if idx==0:
                output += row[idx]
            else:
                
                output += "\t"*(num_tabs[idx-1] - (trunc(len(row[idx-1])/8))) + row[idx]    # The math makes sure the columns are properly spaced
        output += "\n"
    output = output[0:len(output)-1]
    print(output)

def run(labels, select_statement):
    try:
        # Always define your connection cursor to be able to fetch data from the db
        cursor = connection.cursor()
        results = cursor.execute(select_statement)
        print_query(labels, results)
    except:
        pass

if connected:
    go = True
    while go:
        print("\n1 - IDs, agencies, and details of all Chevrolet SUVs")
        print("2 - Rental history of all rented vehicles")
        print("3 - Rental history of all vehicles")
        print("4 - Rates for the long-term leases of each vehicle class")
        print("5 - Long term lease rates greater than $5,500")
        print("6 - Details of all returned rentals")
        print("7 - Longest scheduled lease to date")
        print("q - Quit")
        to_do = input("\nPlease enter the number of the query you would like to see: ")
        if to_do=="q":
            print("\nExiting...")
            go = False
        elif to_do=="1":
            to_run = "SELECT * FROM chevy_suvs"
            lab = ["id", "agency", "plate", "brand", "class"]
            run(lab, to_run)
            again = input("\nWould you like to see another? [y/n]: ")
            if again=="n":
                print("\nExiting...")
                go = False
        elif to_do=="2":
            to_run = "SELECT * FROM rental_history"
            lab = ["vehicle", "agency", "customer id", "vehicle class", "start date", "end date", "return date"]
            run(lab, to_run)
            again = input("\nWould you like to see another? [y/n]: ")
            if again=="n":
                print("\nExiting...")
                go = False
        elif to_do=="3":
            to_run = "SELECT * FROM full_rental_history"
            lab = ["vehicle", "agency", "customer id", "vehicle class", "start date", "end date", "return date"]
            run(lab, to_run)
            again = input("\nWould you like to see another? [y/n]: ")
            if again=="n":
                print("\nExiting...")
                go = False
        elif to_do=="4":
            to_run = "SELECT * FROM longrates"
            lab = ["class", "rate"]
            run(lab, to_run)
            again = input("\nWould you like to see another? [y/n]: ")
            if again=="n":
                print("\nExiting...")
                go = False
        elif to_do=="5":
            to_run = "SELECT * FROM most_profitable"
            lab = ["class", "rate"]
            run(lab, to_run)
            again = input("\nWould you like to see another? [y/n]: ")
            if again=="n":
                print("\nExiting...")
                go = False
        elif to_do=="6":
            to_run = "SELECT * FROM return_price"
            lab = ["vehicle", "class", "client", "cost", "date returned"]
            run(lab, to_run)
            again = input("\nWould you like to see another? [y/n]: ")
            if again=="n":
                print("\nExiting...")
                go = False
        elif to_do=="7":
            to_run = "SELECT * FROM longest_lease"
            lab = ["rental", "start date", "end date", "duration", "client"]
            run(lab, to_run)
            again = input("\nWould you like to see another? [y/n]: ")
            if again=="n":
                print("\nExiting...")
                go = False
        else:
            print("Invalid selection. Please choose from the listed options.")

#TODO: Run "pip install cx_Oracle"
