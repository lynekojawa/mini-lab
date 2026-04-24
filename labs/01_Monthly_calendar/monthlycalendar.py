#Today(4/24) Continue on the project, I was withing to finish this yesterday but apprarently it takes more time
#using a supabase and SQL actually is interesting. let's see how far we can make this today.
#not all import requires the file, some of them has built in feature
#There are new functions in db_manager file, and on the same day we wrote a code, and delete and update


import streamlit as st
import calendar
from db_manager import fetch_calendar_state, get_db_client, upsert_calendar_data
from datetime import date

st.markdown("""
    <style>
    [data-testid="stPopover"] button {
    padding: 0px 5px !important;
    font-size: 2px !important;
    height:10px !important;
    width:40px !important;
    }
    </style
    """, unsafe_allow_html = True)

STATUS_COLORS = {
    "todo": "#F8D7DA",
    "done": "#D4EDDA",
    "memo": "#FFF3CD"
}

def get_status_color(status):
    return STATUS_COLORS.get(status, "#FFFFFF")

def delete_calendar_data(date_key):
    db = get_db_client()
    return db.table("calendar_data").delete().eq("date_key", date_key).execute()


st.set_page_config(page_title="406 Not Acceptable", layout="wide")
st.title("Monthly Calendar")


data = fetch_calendar_state()

for item in data:
    color = get_status_color(item['status'])
    st.markdown(f"""
        <div style = "background-color: {color}; padding: 10px; border-radius: 5px; margin-bottom: 5px;">
            <b>{item['date_key']}</b>: {item['content']}({item['status']})
        </div>
    """, unsafe_allow_html=True)

lookup_map = {item['date_key']: item for item in data}
cal = calendar.monthcalendar(2026, 4)

st.write("### 2026 April")
days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

cols = st.columns(7)
#for i, day in enumerate(days):
    #cols[i].write(f"**{day}**")

for week_row in cal:
    cols = st.columns(7)
    for i, day in enumerate(week_row):
        if day == 0:
            cols[i].write("")
        else:
            curr_date_str = str(date(2026, 4, day))
            item = lookup_map.get(curr_date_str)

            bg_color = get_status_color(item['status']) if item else "#ffffff"
            content_display = f"{day}<br><small>{item['status'] if item else ''}</small>"

            with cols[i].container(border=True, height=140):

                st.markdown(f"""
                           <div style="font-size: 14px; font-weight: bold; background-color:{bg_color}">{content_display}</div>
                           """, unsafe_allow_html=True)

                with st.popover(""):
                    st.write(f"### {curr_date_str}")
                    new_status = st.selectbox("Conditions", ["todo", "done", "memo"],
                                              index=["todo", "done", "memo"].index(item['status']) if item else 0,
                                              key=f"s_{day}")
                    new_content = st.text_input("Details", value=item['content'] if item else "", key=f"c_{day}")

                    c_save, c_del = st.columns(2)
                    if c_save.button("Save", key=f"b_save_{day}"):
                        upsert_calendar_data(curr_date_str, new_status, new_content)
                        st.rerun()
                    if item and c_del.button("Delete", key=f"b_del_{day}"):
                        delete_calendar_data(curr_date_str)
                        st.rerun()



#On the same day we are changing this code, so current code with # read only, and we are going to update this to
#active with administrator create, edit, delete are possible,
            #if curr_date_str in lookup_map:
                #item = lookup_map[curr_date_str]
                #color = get_status_color(item['status'])
                #cols[i].markdown(f"""
                #<div style = "background-color:{color}; padding: 5px; border-radius:5px;">
                    #{day}<br><small>{item['status']}</small
                #</div>
                #""", unsafe_allow_html = True)
            #else:
                #cols[i].write(f"{day}")
