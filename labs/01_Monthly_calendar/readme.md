# 📅 406 Not Acceptable (Monthly Calendar)

## 💡 Why I Built This
I have notification anxiety, and I got tired of the overly complicated systems in current calendar apps. I found that for my productivity, I perform much better with simple listing and checking off tasks rather than controlling myself by the hour. 

## 🛠️ What It Does
This is a calendar app that is ad-free and notification-free. It focuses on personal records rather than external interruptions.
1. **Task Management:** Write lists for memos, to-dos, and completed tasks.
2. **Dynamic State Switching:** Markdown your to-do to done, and easily revert if you clicked accidentally.
3. **Personalized Tracking:** Add or delete anything you need to mark without the noise of modern apps.

## 🏗️ Architecture & Phases

*   **Phase 1: The Cloud Spine (Infrastructure)**
    *   Establish a persistent data layer using Supabase.
    *   Configure `st.secrets` and build a Singleton Connection class for DB lifecycle.
*   **Phase 2: The Logic Engine (State & Color Mapping)**
    *   Map states to a 3-color UI (#F8D7DA: To-Do, #D4EDDA: Done, #FFF3CD: Memo).
    *   Implement dictionary-based date-to-state lookup ($O(1)$).
*   **Phase 3: The Interaction Layer (CRUD & Real-Time)**
    *   Build input modals for date clicks.
    *   Implement write-through caching in `st.session_state` for zero-lag UI.
*   **Phase 4: Security & Audit**
    *   Implement Row-Level Security (RLS).
    *   Graceful degradation via local storage backup.

## 💻 Technical Stack
*   **Python**
*   **SQL**
*   **Streamlit**

## 💡 What I Learned
*   **SQL Foundations:** This was my first time writing SQL, a huge milestone for my data journey.
*   **The UX/Auth Gap:** Creating an app that performs seamlessly across web and mobile is a massive challenge. 
*   **System Design:** I realized the difficulty of integrating frontend and backend authentication (Streamlit Cloud auth vs. custom login flows).

## 🚀 Current Status & Next Steps
*   **Status:** Phase completed. I reached my goal of building a functional, personal calendar.
*   **Next Steps:** I plan to revisit this after studying custom authentication (password management) and refining the UX for a smoother cross-device experience. 

## 🛠️ Project Contributors & Credits
This project is developed through a high-entropy collaboration between human intuition and AI orchestration:

- **Lead Architect**: lynekojawa (human) - Idea, Audit, Architecting, Math
- **Logic Orchestrator**: PODO (Gemini) - Logic, System Design, Code Review
- **Master Planner**: Orion (Gemini) - Master planner 
- **Code Partner**: Dante (Claude) - Git & Implementation support, Code Review
---
*Status: 406 Not Acceptable (but the learning data is 200 OK)*

