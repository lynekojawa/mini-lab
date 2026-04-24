import streamlit as st
from supabase import create_client, Client

@st.cache_resource
def get_db_client():
    url = st.secrets["SUPABASE_URL"]
    key = st.secrets["SUPABASE_KEY"]
    return create_client(url,key)

def fetch_calendar_state():
    db = get_db_client()
    response = db.table("calendar_data").select("*").execute()
    return response.data

def upsert_calendar_data(date_key, status, content):
    db = get_db_client()
    payload = {
        "date_key": date_key,
        "status": status,
        "content": content
    }
    return db.table("calendar_data").upsert(payload).execute()