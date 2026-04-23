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