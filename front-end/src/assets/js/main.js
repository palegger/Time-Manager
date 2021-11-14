const api = "http://localhost:4000/api/"
export const GlobalMethods = {
    methods: {
        customFetch : async function (method, endpoint, body = null) {
            let jwt = localStorage.getItem("jwt");
            let headers = {};
            if (body) headers["Content-Type"] = "application/json"
            if (jwt) headers["security"] = jwt

            const requestOptions = {
                method,
                headers,
                body: body ? JSON.stringify(body) : null
            };
            const response = await fetch(api+endpoint, requestOptions);
            const data = await response.json();

            return {response, data}
        }
    }
}