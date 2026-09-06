# StyleAI — Complete Recommendation Flow

## What is fixed

The application now has a complete working path:

**Upload photo → choose occasion → choose outfit type → choose color → Get AI Recommendation → recommendation result + next step**

The frontend calls `POST /api/recommend`, the Flask backend saves the image, runs `ai/recommendation.py`, and returns structured recommendation data. If the backend is temporarily unavailable, the frontend shows a local fallback recommendation instead of getting stuck.

## Important limitation

The included recommendation engine is **rule-based**, not a trained computer-vision model. It uses the selected options and confirms the uploaded image was received. It does not infer body shape, skin tone, existing clothing, etc. To add real image understanding, integrate a vision model/API inside `ai/recommendation.py`.

## Windows — easiest way

Double-click:

`run.bat`

The script creates a virtual environment, installs dependencies, starts Flask and opens the browser.

## Manual Windows setup

From the project root:

```bash
python -m venv venv
venv\Scripts\activate
pip install -r backend\requirements.txt
python backend\app.py
```

Open:

`http://127.0.0.1:5000`

## macOS/Linux

```bash
chmod +x run.sh
./run.sh
```

Then open `http://127.0.0.1:5000`.

## Folder map

- `frontend/index.html` — page and recommendation result section
- `frontend/style.css` — styling
- `frontend/script.js` — upload, validation, API call, loading state, result rendering and fallback
- `backend/app.py` — Flask server and `/api/recommend` endpoint
- `backend/requirements.txt` — Python packages
- `ai/recommendation.py` — recommendation engine
- `uploads/` — uploaded photos
- `database/database.sql` — optional MySQL schema
- `run.bat` — one-click Windows startup
- `run.sh` — macOS/Linux startup

## Important: README.md is not the website

If you see this README text in your browser, you have opened `README.md` instead of the StyleAI website. Close that tab and use the URL below:

`http://127.0.0.1:5000/`

## If the button still appears not to work

1. Double-click `run.bat`.
2. Keep the **StyleAI Server** black Command Prompt window open.
3. Wait until it says `StyleAI is running at http://127.0.0.1:5000`.
4. Open `http://127.0.0.1:5000/` in Chrome.
5. Upload the photo, choose Occasion, Outfit Type and Preferred Color.
6. Click **Get AI Recommendation**.

You can also double-click `open_styleai.bat` after the server is running.

### If you get a Python/package error

Make sure Python 3.10+ is installed and available as `python` in Command Prompt. Then run `run.bat` again.
