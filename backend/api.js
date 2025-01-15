const express = require('express');
const app = express();
const db = require('./db-connection');

app.get('/contributors/:address', (req, res) => {
    const address = req.params.address;
    // Placeholder for fetching contributor data
    res.send(`Fetching contribution data for address: ${address}`);
});

app.listen(3000, () => console.log('Server running on port 3000'));