const request = require('supertest');
const app = require('../app');

describe('Get Endpoints', () => {
    it('should get some emojis', async () => {
        let res = await request(app)
            .get('/').expect(200, {message: "🦄🌈✨👋🌎🌍🌏✨🌈🦄"});
    });
    it('should give a not found error', async () => {
        let res = await request(app)
            .get('/loll').expect(404, {title:"Something went wrong!",msg:"🔍 - Not Found - /loll"});
    });
})
