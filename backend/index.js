import { Hono } from "hono";
import { cors } from "hono/cors";
import OpenAI from "openai";

const app = new Hono();

// Enable CORS for all routes
app.use("*", cors());

// In-memory data storage (simple arrays)
let doctors = [
  {
    id: 1,
    name: "Dr. Mayowa",
    specialty: "General",
    available: true,
    experience: 20,
    rating: 5.0,
  },
  {
    id: 2,
    name: "Dr. Michael Chen",
    specialty: "Dermatology",
    available: true,
    experience: 8,
    rating: 4.1,
  },
  {
    id: 3,
    name: "Dr. Emily Rodriguez",
    specialty: "Pediatrics",
    available: true,
    experience: 12,
    rating: 4.3,
  },
  {
    id: 4,
    name: "Dr. David Kim",
    specialty: "Orthopedics",
    available: false,
    experience: 10,
    rating: 4.0,
  },
];

let bookings = [
  {
    id: 1,
    patientName: "John Smith",
    patientEmail: "john@email.com",
    doctorId: 1,
    doctorName: "Dr. Mayowa",
    date: 14,
    time: "8:30",
    status: "confirmed",
    isUrgent: false,
  },
  {
    id: 2,
    patientName: "Alice Brown",
    patientEmail: "alice@email.com",
    doctorId: 1,
    doctorName: "Dr. Mayowa",
    date: 14,
    isUrgent: false,
    time: "9:30",
    status: "confirmed",
  },
];

// API Routes
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
  baseURL:"https://openrouter.ai/api/v1",
});

const runOllama = async (
  systemPrompt,
  userPrompt,
  temperature = 0.01
) => {
  //if another model is running and that model is not the EMBEDDING_MODEL, stop the running model

  //OPENAI
  const completion = await openai.chat.completions.create({
    // model: "google/gemma-3-27b-it:free",
    model: "qwen/qwen2.5-vl-32b-instruct:free",
    messages: [
      { role: "system", content: systemPrompt },
      { role: "user", content: userPrompt },
    ],
    temperature: temperature,
    top_p: 0.9,
  });

  return completion.choices[0].message.content;
};

// Get all available doctors (for patients)
app.get("/api/doctors", (c) => {
  const availableDoctors = doctors.filter((doctor) => doctor.available);
  return c.json(availableDoctors);
});

app.post("api/ai",async (c) => {
  const body = await c.req.json();
  let finalJson;
  try {
     let llmAnswer = await runOllama(
    "You are a helpful medical assistant. Provide helpful and accurate information while being empathetic and professional. Keep responses concise and under 100 words when possible. If the user asks for advice beyond your expertise, recommend consulting a healthcare professional. If the user's request is extremely urgent and requires immediate attention, suggest a single doctor to book from the below list" + JSON.stringify(doctors),
    [
      {
        type: "text",
        text: body.userPrompt,
      }
    ]
  );
    finalJson = llmAnswer;
  } catch (error) {
    console.log(error);
  }
  return c.json({ data: finalJson });
})

// Get all doctors (including unavailable)
app.get("/api/doctors/all", (c) => {
  return c.json(doctors);
});

// Book a doctor (for patients)
app.post("/api/bookings", async (c) => {
  try {
    const { patientName, patientEmail, doctorId, date,time,day,isUrgent } =
      await c.req.json();

    // Validate required fields
    if (!patientName || !patientEmail || !doctorId || !date || !time) {
      return c.json({ error: "All fields are required" }, 400);
    }

    // Check if doctor exists and is available
    const doctor = doctors.find((d) => d.id === doctorId);
    if (!doctor) {
      return c.json({ error: "Doctor not found" }, 404);
    }

    if (!doctor.available) {
      return c.json({ error: "Doctor is not available" }, 400);
    }

    // Create new booking
    const newBooking = {
      id: bookings.length + 1,
      patientName,
      patientEmail,
      doctorId,
      doctorName: doctor.name,
      date,time,day,
      isUrgent: isUrgent || false,
      status: "confirmed",
    };

    bookings.push(newBooking);

    return c.json(
      {
        message: "Booking successful",
        booking: newBooking,
      },
      201
    );
  } catch (error) {
    return c.json({ error: "Invalid request data" }, 400);
  }
});

// Get bookings for a specific doctor
app.get("/api/doctor/:doctorId/bookings", (c) => {
  const doctorId = parseInt(c.req.param("doctorId"));

  if (isNaN(doctorId)) {
    return c.json({ error: "Invalid doctor ID" }, 400);
  }

  const doctorBookings = bookings.filter(
    (booking) => booking.doctorId === doctorId
  );

  return c.json(doctorBookings);
});

// Get all bookings (for admin/doctors overview)
app.get("/api/bookings", (c) => {
  return c.json(bookings);
});

// Update booking status (for doctors)
app.patch("/api/bookings/:bookingId", async (c) => {
  try {
    const bookingId = parseInt(c.req.param("bookingId"));
    const { status } = await c.req.json();

    if (isNaN(bookingId)) {
      return c.json({ error: "Invalid booking ID" }, 400);
    }

    const validStatuses = ["confirmed", "cancelled", "completed"];
    if (!validStatuses.includes(status)) {
      return c.json({ error: "Invalid status" }, 400);
    }

    const booking = bookings.find((b) => b.id === bookingId);
    if (!booking) {
      return c.json({ error: "Booking not found" }, 404);
    }

    booking.status = status;

    return c.json({
      message: "Booking status updated",
      booking,
    });
  } catch (error) {
    return c.json({ error: "Invalid request data" }, 400);
  }
});

// Health check endpoint
app.get("/health", (c) => {
  return c.json({ status: "OK", timestamp: new Date().toISOString() });
});

const port = 3000;

console.log(`🚀 Doctor Booking API server starting on port ${port}...`);
console.log(`📋 Available endpoints:`);
console.log(`   GET  /api/doctors - Get available doctors`);
console.log(`   GET  /api/doctors/all - Get all doctors`);
console.log(`   POST /api/bookings - Book a doctor`);
console.log(`   GET  /api/doctor/:id/bookings - Get doctor's bookings`);
console.log(`   GET  /api/bookings - Get all bookings`);
console.log(`   PATCH /api/bookings/:id - Update booking status`);
console.log(`   GET  /health - Health check`);

export default {
  port,
  fetch: app.fetch,
};
