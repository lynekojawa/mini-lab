#Today(4/23) we are going to create monthly calendar
#this is one day project and here are the features we need in this calendar
#Montly calendar, and years for saving and representing purpose
#No ads, no subscription.
#There is three categories 1. list that's done 2. list that's to-do 3. memo
#no more, no less :D
#Use supabase and create the SQL table for the first time!

import streamlit as st
from db_manager import fetch_calendar_state, get_db_client

STATUS_COLORS = {
    "todo": "#F8D7DA",
    "done": "#D4EDDA",
    "memo": "#FFF3CD"
}

def get_status_color(status):
    return STATUS_COLORS.get(status, "#FFFFFF")

st.set_page_config(page_title="406 Acceptable", layout="wide")
st.title("Monthly Calendar")

def add_test_data():
    client = get_db_client()
    test_payload = {
        "date_key": "2026-04-23",
        "status": "todo",
        "content": "testdata"
    }
    try:
        client.table("calendar_data").insert(test_payload).execute()
        return True
    except Exception as e:
        st.error(f"details:{e}")
        return False

if st.button("Injection"):
    if add_test_data():
        st.success("Successfully injected data(refresh)")
    else:
        st.error("Failed to inject data")

data = fetch_calendar_state()

for item in data:
    color = get_status_color(item['status'])
    st.markdown(f"""
        <div style = "background-color: {color}; padding: 10px; border-radius: 5px; margin-bottom: 5px;">
            <b>{item['date_key']}</b>: {item['content']}({item['status']})
        </div>
    """, unsafe_allow_html=True)