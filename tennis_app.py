import streamlit as st
import pandas as pd
from sqlalchemy import create_engine

# DB Connection
engine = create_engine("mysql+pymysql://root:root@localhost/tennis_db")

st.title("🎾 Tennis Analytics Dashboard")

# Load data
query = """
SELECT c.name, c.country, r.player_rank, r.points, r.movement
FROM Competitor_Rankings r
JOIN Competitors c ON r.competitor_id = c.competitor_id
"""
df = pd.read_sql(query, engine)

# Sidebar filters
st.sidebar.header("Filters")

country = st.sidebar.selectbox("Select Country", ["All"] + list(df["country"].unique()))

rank_range = st.sidebar.slider("Select Rank Range", 1, 10, (1, 5))

# Apply filters
filtered_df = df.copy()

if country != "All":
    filtered_df = filtered_df[filtered_df["country"] == country]

filtered_df = filtered_df[
    (filtered_df["player_rank"] >= rank_range[0]) &
    (filtered_df["player_rank"] <= rank_range[1])
]

# KPI
st.subheader("📊 Key Metrics")
st.write("Total Competitors:", len(filtered_df))
st.write("Average Points:", round(filtered_df["points"].mean(), 2))

# Table
st.subheader("🏆 Competitor Rankings")
st.dataframe(filtered_df)

# Chart
st.subheader("📈 Points vs Rank")
st.bar_chart(filtered_df.set_index("name")["points"])