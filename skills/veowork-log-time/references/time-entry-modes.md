# Time entry modes

Read `get_time_entry_settings` before logging time.
`worklogDisplay.showStartEndTimes` is `false` for Duration mode and `true` for Time mode.
The tool returns only the authenticated person's preference. Personal write tools also act only on that person.
It does not read another author's settings or authorize logging for someone else.

- **Duration mode:** the server stores new entries at **12:00 noon** on the requested local date, ignoring supplied clock times, including explicit or saved start times.
- **Time mode:** honor explicit start times, then saved instructions. Otherwise use the current local time today, reading a current clock, or 09:00 for other dates.

In Duration mode, supply `add_worklog.timestamp` as a date, for example `2026-10-25`.
Full timestamps remain accepted. In Time mode, a full timestamp including seconds is required;
a date alone is rejected without writing.
The server uses the supplied local date without timezone conversion.
Noon is a storage placeholder, not evidence that work started at noon.
Keep the skill's date, time-zone, duration, and authorization rules.
If settings cannot be read, report the missing mode and continue discovery; do not guess a clock default.

For updates, omit `timestamp` when changing only duration or metadata.
In Duration mode, move an entry with `update_worklog.timestamp: "2026-10-25"`.
In Time mode, replace only the date component of the full timestamp; preserve its clock time and precision.
In Duration mode, the server ignores supplied clock changes and retains the existing clock component.
Changing modes does not rewrite existing entries or derive times from stacked card positions.
The worklog owner's mode controls writes, including edits performed by a manager through other APIs.
`set_timesheet_entry` uses noon for new daily entries in either mode and retains an existing survivor's timestamp.

Report dates and durations in Duration mode. Include the stored clock time only when requested or needed to explain a timestamp issue.
If a clock time was requested in Duration mode, explain that it was ignored and noon was stored for a new entry.
In Time mode, include the saved start time for a new worklog.
