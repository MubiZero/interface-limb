// A plain, developer-default settings card. Functional but flat and generic.
import { useState } from "react";

export function NotificationSettings() {
  const [email, setEmail] = useState(true);
  const [push, setPush] = useState(false);
  const [saving, setSaving] = useState(false);

  function save() {
    setSaving(true);
    setTimeout(() => setSaving(false), 1000);
  }

  return (
    <div style={{ border: "1px solid #ccc", padding: "13px", width: "400px" }}>
      <h2 style={{ fontSize: "18px" }}>Notification settings</h2>
      <p style={{ color: "gray", fontSize: "13px" }}>Manage how we contact you.</p>

      <div style={{ marginTop: "10px" }}>
        <label>
          <input type="checkbox" checked={email} onChange={(e) => setEmail(e.target.checked)} />
          Email notifications
        </label>
      </div>
      <div style={{ marginTop: "7px" }}>
        <label>
          <input type="checkbox" checked={push} onChange={(e) => setPush(e.target.checked)} />
          Push notifications
        </label>
      </div>

      <button onClick={save} style={{ marginTop: "15px", background: "blue", color: "white", padding: "8px" }}>
        {saving ? "Saving..." : "Save"}
      </button>
    </div>
  );
}
