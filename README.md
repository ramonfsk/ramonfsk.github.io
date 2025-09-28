# Ramon's Blog

My personal blog where I write about technology, anime, and other interesting topics.

## Prerequisites

Before running this project locally, make sure you have the following installed:

- [Hugo](https://gohugo.io/getting-started/installing/) (Static site generator)
- [Go](https://golang.org/doc/install) (Required for Hugo modules)
- [Git](https://git-scm.com) (Version control)

## Running Locally

1. Clone the repository
```bash
git clone https://github.com/ramonfsk/ramonfsk.github.io.git
```

2. Change to the project directory
```bash
cd ramonfsk.github.io
```

3. Install Hugo modules
```bash
hugo mod tidy
```

4. Start the development server
```bash
hugo server -D
```

The site will be available at `http://localhost:1313`

## Contributing

Contributions are welcome! If you'd like to contribute:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Theme

This blog uses [Hextra](https://github.com/imfing/hextra) theme for Hugo.