#Today(4/27) We are continuing the montly calendar there are some known error I found
#1. cannot put more than 2 inputs Not yet
#2. I personally feel annoys this listed on the top V
#3. wanted to add next month and previous calendar V

import streamlit as st
import calendar
from db_manager import fetch_calendar_state, get_db_client, add_calendar_entry, delete_calendar_entry
from datetime import date
from collections import defaultdict

if 'view_month' not in st.session_state:
    st.session_state.view_month = date.today().month
if 'view_year' not in st.session_state:
    st.session_state.view_year = date.today().year

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

c1, c2, c3= st.columns([.5,3,.4])
if c1.button("<- previous month"):
    st.session_state.view_month = (st.session_state.view_month -2) % 12 +1
    if st.session_state.view_month ==12: st.session_state.view_year -= 1
    st.rerun()
month_name = calendar.month_name[st.session_state.view_month]

c2.write(f"""
<h1 style = 'text-align: center;'>{st.session_state.view_year} {month_name}</h2>
""", unsafe_allow_html = True)

if c3.button("next month ->"):
    st.session_state.view_month = (st.session_state.view_month % 12) +1
    if st.session_state.view_month == 1: st.session_state.view_year += 1
    st.rerun()


data = fetch_calendar_state(st.session_state.view_year, st.session_state.view_month)


lookup_map = defaultdict(list)
for item in data:
    lookup_map[item['date_key']].append(item)

cal = calendar.monthcalendar(st.session_state.view_year, st.session_state.view_month)

cols = st.columns(7)

for i, day in enumerate(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]):
    cols[i].write(f"**{day}**")

for week_row in cal:
    cols = st.columns(7)
    for i, day in enumerate(week_row):
        if day == 0:
            cols[i].write("")
        else:
            curr_date_str = str(date(st.session_state.view_year, st.session_state.view_month, day))
            entries = lookup_map.get(curr_date_str,[])
            has_entries = len(entries) > 0
            bg_color = "#F8F9FA" if has_entries else "#FFFFFF"

            u_key = f"{st.session_state.view_year}_{st.session_state.view_month}_{day}"

            with cols[i].container(border=True, height=140):

                st.markdown(f"""
                           <div style="font-size: 14px; font-weight: bold; background-color:{bg_color}";
                           padding: 5px; border-radius: 5px;">
                                {day}
                           </div>
                           """, unsafe_allow_html=True)

                for entry in entries:
                    st.write(entry)
                    status_color = get_status_color(entry['status'])

                with st.popover("+"):
                    st.write(f"### {curr_date_str}")
                    st.subheader("Add New")
                    new_status = st.selectbox("Status", ["todo", "done", "memo"], key = f"s_new_{u_key}")
                    new_content = st.text_input("Details", key=f"c_new_{u_key}")

                    if st.button("Add", key=f"b_add_{u_key}"):
                        add_calendar_entry(curr_date_str, new_status, new_content)
                        st.rerun()

                    st.divider()

                    if entries:
                        st.subheader("Existing Entries")
                        for entry in entries:
                            col_txt, col_del = st.columns([4, 1])
                            entry_id = entry.get('id')
                            with col_txt:
                                st.write(f"**{entry['status']}**: {entry['content']}")
                            with col_del:
                                if entry_id:
                                    if st.button("🗑️", key=f"del_{entry['id']}"):
                                        delete_calendar_entry(entry['id'])
                                        st.rerun()
                                else:
                                    st.warning("NO ID found")




