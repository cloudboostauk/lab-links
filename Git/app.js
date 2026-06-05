// =============================================
//  PartyRadar Diaspora — app.js
//  Data, card builder, and RSVP form handler
// =============================================

// --- Events Data ---
const EVENTS = [
    {
      id: 'evt001',
      name: 'Naija Nite London',
      city: 'London',
      venue: 'EartH Theatre, Hackney',
      date: '14 Feb 2025',
      time: '9:00 PM',
      type: 'Owambe & Afrobeats',
      price: '£20',
      spots: 18
    },
    {
      id: 'evt002',
      name: 'Houston Owambe Massive',
      city: 'Houston',
      venue: 'Midtown Arts & Theatre Center',
      date: '22 Feb 2025',
      time: '8:00 PM',
      type: 'Owambe & Jollof Cook-off',
      price: '$25',
      spots: 34
    },
    {
      id: 'evt003',
      name: 'Toronto Naija Night',
      city: 'Toronto',
      venue: 'Rebel Entertainment Complex',
      date: '1 Mar 2025',
      time: '10:00 PM',
      type: 'Afrobeats & Amapiano',
      price: 'CA$30',
      spots: 12
    },
    {
      id: 'evt004',
      name: 'Dubai Detty December Late',
      city: 'Dubai',
      venue: 'White Beach at Atlantis',
      date: '7 Mar 2025',
      time: '8:30 PM',
      type: 'Beach Party & Afrobeats',
      price: 'AED 80',
      spots: 50
    },
    {
      id: 'evt005',
      name: 'Atlanta Jollof Jam',
      city: 'Atlanta',
      venue: 'The Basement Atlanta',
      date: '15 Mar 2025',
      time: '9:00 PM',
      type: 'Afrobeats & Food Festival',
      price: '$20',
      spots: 27
    },
    {
      id: 'evt006',
      name: 'Manchester Naija Carnival',
      city: 'Manchester',
      venue: 'Albert Hall, Manchester',
      date: '22 Mar 2025',
      time: '9:30 PM',
      type: 'Live Music & Owambe',
      price: '£18',
      spots: 9
    }
  ];
  
  // --- Card Builder ---
  // Takes one event object and returns an HTML card string
  function buildCard(event) {
    return `
      <div class="card">
        <div class="card-banner">
          <div class="city-tag">${event.city}</div>
          <div class="event-name">${event.name}</div>
          <div class="event-type">${event.type}</div>
        </div>
        <div class="card-body">
          <div class="card-meta">
            <span>${event.date} &nbsp;·&nbsp; ${event.time}</span>
            <span>${event.venue}</span>
          </div>
          <div class="card-footer">
            <div class="card-price">${event.price}</div>
            <div class="card-spots">${event.spots} spots left</div>
          </div>
        </div>
      </div>
    `;
  }
  
  // --- RSVP Form Handler ---
  function submitRSVP() {
    const name  = document.getElementById('full-name').value.trim();
    const email = document.getElementById('email').value.trim();
    const event = document.getElementById('event-select').value;
  
    if (!name) {
      alert('Please enter your full name.');
      return;
    }
    if (!email || !email.includes('@')) {
      alert('Please enter a valid email address.');
      return;
    }
    if (!event) {
      alert('Please select an event.');
      return;
    }
  
    // Show success message
    const success = document.getElementById('rsvp-success');
    success.style.display = 'block';
  
    // Scroll to success message
    success.scrollIntoView({ behavior: 'smooth', block: 'center' });
  }