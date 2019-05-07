export interface request {}

export interface Navigator {
    navigate: (path: string) => void
}

export interface response {
    mount: any
    redirect: (path: string) => void
    ctx?: any
}

export type handlerFunc = (req: request, res: response) => void

export class Router {
    middleware: handlerFunc[] = []
    routes: Record<string, handlerFunc[]> = {}

    path(path: string, ...handlers: handlerFunc[]) {
        this.routes[path] = handlers
    }

    use(handler: handlerFunc) {
        this.middleware.push(handler)
    }

    navigate(path: string) {
        window.history.pushState(null, document.title, path)
        this.load()
    }

    async load() {
        const path = window.location.pathname
        const req = {}
        const res = {
            mount: console.log,
            redirect: (path: string) => this.navigate(path),
            ctx: {}
        }
        for (const middleware of this.middleware) {
            await middleware(req, res)
        }
        for (const handler of this.routes[path]) {
            await handler(req, res)
        }
    }
}

export const create = () => new Router()

