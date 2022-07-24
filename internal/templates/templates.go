package templates

import (
	"github.com/koopa0/vigilate/internal/models"
)

// TemplateData defines template data
type TemplateData struct {
	CSRFToken       string
	IsAuthenticated bool
	PreferenceMap   map[string]string
	User            models.User
	Flash           string
	Warning         string
	Error           string
	GwVersion       string
}
