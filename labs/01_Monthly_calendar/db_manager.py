import streamlit as st
import calendar
from supabase import create_client, Client

@st.cache_resource
def get_db_client():
    url = st.secrets["SUPABASE_URL"]
    key = st.secrets["SUPABASE_KEY"]
    return create_client(url,key)

def fetch_calendar_state(year, month):
    db = get_db_client()
    _, last_day = calendar.monthrange(year,month)
    start_date = f"{year}-{month:02d}-01"
    end_date = f"{year}-{month:02d}-{last_day}"

    return db.table("calendar_data")\
             .select("*")\
             .gte("date_key",start_date) \
             .lte("date_key", end_date)\
             .execute().data

def add_calendar_entry(date_key, status, content):
    db = get_db_client()
    return db.table("calendar_data").insert({
        "date_key": date_key,
        "status": status,
        "content": content
    }).execute()

def delete_calendar_entry(entry_id):
    db = get_db_client()
    return db.table("calendar_data").delete().eq("id", entry_id).execute()